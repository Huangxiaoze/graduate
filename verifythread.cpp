#include "verifythread.h"
#include <QDebug>
#include <QMessageBox>
#include <iostream>
#include <QJsonDocument>
VerifyThread::VerifyThread(QObject *parent) : QThread(parent)
{

}

VerifyThread::~VerifyThread() {
    qDebug() << "MaraboutVerifyThread::MarabouVerifyThread(): destroy marabou verify thread..." << endl;
}

void VerifyThread::setParameter(PyObject* origin_net, PyObject* abstract_net, PyObject* abstract_orig_net, PyObject* test_property, QJsonObject parameter) {
    this->origin_net_ = origin_net;
    this->abstract_net_ = abstract_net;
    this->abstract_orig_net_ = abstract_orig_net;
    this->test_property_ = test_property;
    this->parameter_ = parameter;
}

void VerifyThread::run() {
    qDebug() << "thread start run..." << endl;
    qDebug() << parameter_ << endl;
    PyObject *verify_func = nullptr;
    PyObject *arg = nullptr;
    int verify_mode = parameter_.value("verify_mode").toInt();
    qDebug() << "verify_mode=" << verify_mode << endl;

    parameter_["planet"] = "./planet";
    QString json_content = QString(QJsonDocument(parameter_).toJson());

    switch (verify_mode) {
    case VERIFY_WITHOUT_AR:
    {
        if (origin_net_ == nullptr) {
            QMessageBox::warning(nullptr, "Warning", "network is null, please check your network file.");
            return;
        }
        verify_func = python.getFunc("core.prodeep.prodeep", "verify_without_ar");
        arg = Py_BuildValue("(O, s)", this->origin_net_,
                                          json_content.toStdString().c_str());
        break;
    }
    case VERIFY_WITH_AR:
    {
        if (abstract_net_ == nullptr) {
            QMessageBox::warning(nullptr, "Warning", "network is null, please check your network file.");
            return;
        }
        verify_func = python.getFunc("core.prodeep.prodeep", "verify_with_ar");
        arg = Py_BuildValue("(O, O, O, s, s, i, i)",
                                this->abstract_net_,
                                this->abstract_orig_net_,
                                this->test_property_,
                                parameter_.value("refinement_type").toString().toStdString().c_str(),
                                parameter_.value("abstract_type").toString().toStdString().c_str(),
                                parameter_.value("refinement_sequence").toString().toInt(),
                                parameter_.value("abstraction_sequence").toString().toInt()
                            );
        break;
    }
    case PLANET_WITH_AR:
    {
        verify_func = python.getFunc("core.prodeep.prodeep", "planet_with_ar");
        arg = Py_BuildValue("(s)", json_content.toStdString().c_str());
        break;
    }
    case PLANET_WITHOUT_AR:
    {
        verify_func = python.getFunc("core.prodeep.prodeep", "planet_without_ar");
        arg = Py_BuildValue("(s)", json_content.toStdString().c_str());
    }
    default:
        break;
    }

    if (verify_func == nullptr) {
        qDebug() << "verify interface is not found......" << endl;
        return;
    }

    if (arg == nullptr) {
        qDebug() << "arg construct failure.... " << endl;
        return;
    }

    PyObject *ret = PyEval_CallObject(verify_func, arg);
    emit SIGNAL_finish_verify(ret, this);
}
