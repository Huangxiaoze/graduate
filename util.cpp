#include <Python.h>
#include "util.h"
#include "projectview.h"
#include <QDir>
#include <QDebug>

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
    //初始化python
//    Py_Initialize();

    //直接运行python代码
    PyRun_SimpleString("print('----------Python Start')");

    //引入当前路径,否则下面模块不能正常导入
    PyRun_SimpleString("import sys");
    PyRun_SimpleString("sys.path.append('./')");

    //引入模块
    PyRun_SimpleString("print('----------PyImport_ImportModule')");

    PyObject *core_nnet_read_nnet = PyImport_ImportModule("core.nnet.read_nnet");

    PyObject *pFunc1 = PyObject_GetAttrString(core_nnet_read_nnet, "network_from_nnet_file");
    PyObject *pArg1 = Py_BuildValue("(s)", "../../nnet/ACASXU_run2a_1_1_batch_2000.nnet");
    PyObject *net = PyEval_CallObject(pFunc1, pArg1);

    PyObject *pFunc2 = PyObject_GetAttrString(core_nnet_read_nnet, "get_network_in_json_str");
    PyObject *pArg2 = Py_BuildValue("(O)", net);
    PyObject *str = PyEval_CallObject(pFunc2, pArg2);
    char *content = NULL;
    PyArg_Parse(str,"s", &content);

    QString value = content;

    //释放python
//    Py_Finalize();
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
