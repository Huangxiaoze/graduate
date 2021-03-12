#include <Python.h>
#include "util.h"
#include "init_python.h"
#include "projectview.h"
#include <QDir>
#include <QDebug>

extern Python python;

Util::Util()
{

}
int Util::createFile( const QString filePath, const QString fileName)
{
    QDir tempDir;
    QString currentDir = tempDir.currentPath();
    if(!tempDir.exists(filePath))
    {
        tempDir.mkpath(filePath);
    }
    QFile *tempFile = new QFile;
    tempDir.setCurrent(filePath);
    if(tempFile->exists(fileName))
    {
        qDebug()<<fileName<<QObject::tr("already Exist");

        tempDir.setCurrent(currentDir);
        return CREATE_FILE_FAILED;
    }
    tempFile->setFileName(fileName);
    if(!tempFile->open(QIODevice::WriteOnly|QIODevice::Text))
    {

        tempDir.setCurrent(currentDir);
        return CREATE_FILE_FAILED;
    }
    tempFile->close();
    tempDir.setCurrent(currentDir);
    return CREATE_FILE_SUCCESS;
}

QJsonObject * Util::parseJsonFile(const QString fileName)
{
    //QDir filepath(filePath);

    QFile file(fileName);
        file.open(QIODevice::ReadOnly | QIODevice::Text);
        QString value = file.readAll();
        file.close();

        QJsonParseError parseJsonErr;
        QJsonDocument document = QJsonDocument::fromJson(value.toUtf8(),&parseJsonErr);
        if(!(parseJsonErr.error == QJsonParseError::NoError))
        {
            qDebug()<<"解析json文件错误！";
            return nullptr;
        }
        QJsonObject *  result = new QJsonObject();
        *result = document.object();
        return result;
}

QJsonObject* Util::parseJsonFile_python(const QString fileName) {
    PyRun_SimpleString("import sys");
    PyRun_SimpleString("sys.path.append('./')");

    PyObject *pFunc1 = python.getFunc("core.nnet.read_nnet", "network_from_nnet_file");
    PyObject *pArg1 = Py_BuildValue("(s)", fileName.toStdString().c_str());
    PyObject *net = PyEval_CallObject(pFunc1, pArg1);

    PyObject *pFunc2 = python.getFunc("core.nnet.read_nnet", "get_network_in_json_str");
    PyObject *pArg2 = Py_BuildValue("(O)", net);
    PyObject *str = PyEval_CallObject(pFunc2, pArg2);
    char *content = NULL;
    PyArg_Parse(str,"s", &content);

    QString value = content;
    QJsonParseError parseJsonErr;
    QJsonDocument document = QJsonDocument::fromJson(value.toUtf8(),&parseJsonErr);
    if(!(parseJsonErr.error == QJsonParseError::NoError))
    {
        qDebug()<<"解析json文件错误！";
        return nullptr;
    }
    QJsonObject *  result = new QJsonObject();
    *result = document.object();
    return result;
}

PyObject* Util::read_network_file(QString filepath) {
    PyRun_SimpleString("import sys");
    PyRun_SimpleString("sys.path.append('./')");

    PyObject *pFunc1 = python.getFunc("core.nnet.read_nnet", "network_from_nnet_file");
    PyObject *pArg1 = Py_BuildValue("(s)", filepath.toStdString().c_str());
    PyObject *net = PyEval_CallObject(pFunc1, pArg1);

    return net;
}

QJsonObject* Util::parsePyNetwork(PyObject *net) {
    if (net == nullptr) {
        qDebug() << "Util::parsePyNetwork: net is null. " << endl;
        return nullptr;
    }
    PyObject *pFunc2 = python.getFunc("core.nnet.read_nnet", "get_network_in_json_str");
    PyObject *pArg2 = Py_BuildValue("(O)", net);
    PyObject *str = PyEval_CallObject(pFunc2, pArg2);
    return parseJsonPyObject(str);
}

QJsonObject* Util::parseJsonPyObject(PyObject *obj) {
    char *content = NULL;
    PyArg_Parse(obj,"s", &content);
//    qDebug() << content << endl;
    QString value = content;
    QJsonParseError parseJsonErr;
    QJsonDocument document = QJsonDocument::fromJson(value.toUtf8(),&parseJsonErr);
    if(!(parseJsonErr.error == QJsonParseError::NoError))
    {
        qDebug()<<"解析json错误！";
        return nullptr;
    }
    QJsonObject *  result = new QJsonObject();
    *result = document.object();
    return result;
}
