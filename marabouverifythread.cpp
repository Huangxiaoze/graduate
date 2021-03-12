#include "marabouverifythread.h"
#include <QDebug>
#include <QMessageBox>
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
        QMessageBox::warning(nullptr, "Warning", "network is null, please check your network file.");
        return;
    }
    qDebug() << parameter_ << endl;
    PyObject *verify_func = nullptr;
    PyObject *arg = nullptr;
    int verify_mode = parameter_.value("verify_mode").toInt();
    qDebug() << "verify_mode=" << verify_mode << endl;
    switch (verify_mode) {
    case VERIFY_WITHOUT_AR:
    {
        verify_func = python.getFunc("core.prodeep.prodeep", "verify_without_ar");
        arg = Py_BuildValue("(O, s)", this->net_,
                                          this->parameter_.value("property_id").toString().toStdString().c_str());
        break;
    }
    case VERIFY_WITH_AR:
    {
        verify_func = python.getFunc("core.prodeep.prodeep", "verify_with_ar");
        arg = Py_BuildValue("(O, s, s, i, i, s)",
                                this->net_,
                                parameter_.value("refinement_type").toString().toStdString().c_str(),
                                parameter_.value("abstract_type").toString().toStdString().c_str(),
                                parameter_.value("refinement_sequence").toString().toInt(),
                                parameter_.value("abstraction_sequence").toString().toInt(),
                                parameter_.value("property_id").toString().toStdString().c_str()
                            );
        break;
    }
    default:
        break;
    }

    if (verify_func == nullptr || arg == nullptr) {
        qDebug() << "verify interface is not found or arg construct failure......" << endl;
        return;
    }

    PyObject *ret = PyEval_CallObject(verify_func, arg);
    emit SIGNAL_finish_verify(ret, this);
}
