#ifndef UTIL_H
#define UTIL_H

#include <Python.h>
#include <QString>
#include <QWidget>
#include <QJsonDocument>
#include <QJsonParseError>
#include <QJsonObject>



class Util
{
public:
    Util();
    static int createFile(const QString filePath, const QString fileName);
    static QJsonObject * parseJsonFile(const QString fileName);
//    huangxiaoze --- start
    static QJsonObject * parseJsonFile_python(const QString fileName);
    static PyObject* read_network_file(QString filepath);
    static QJsonObject* parsePyNetwork(PyObject*);
    static QJsonObject* parseJsonPyObject(PyObject*);
    static QString getOutputString(QJsonObject *jsonObj, const char* = nullptr);
//    huangxiaoze ---- end
};


#endif // UTIL_H
