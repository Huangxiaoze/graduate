#include "marabouverifythread.h"
#include <QDebug>

MarabouVerifyThread::MarabouVerifyThread(QObject *parent) : QThread(parent)
{

}

MarabouVerifyThread::~MarabouVerifyThread() {
    qDebug() << "MaraboutVerifyThread::MarabouVerifyThread(): destroy marabou verify thread..." << endl;
}

void MarabouVerifyThread::setParameter(PyObject* net, QJsonObject parameter) {
    this->net_ = net;
    this->parameter_ = parameter;
}

void MarabouVerifyThread::run() {
    qDebug() << "thread start run..." << endl;
    if (net_ == nullptr) {
        return;
    }
    PyObject *verify_func = nullptr;
    int verify_mode = parameter_.value("verify_mode").toString().toInt();
    switch (verify_mode) {
    case VERIFY_WITH_AR:
        break;
    case VERIFY_WITHOUT_AR:
        verify_func = python.getFunc("core.prodeep.prodeep", "verify_without_ar");
        break;
    default:
        break;
    }

    if (verify_func == nullptr) {
        qDebug() << "verify interface not found......" << endl;
        return;
    }

    PyObject *arg = Py_BuildValue("(O, s)", this->net_,
                                  this->parameter_.value("property_id").toString().toStdString().c_str());
    PyObject *ret = PyEval_CallObject(verify_func, arg);
}
