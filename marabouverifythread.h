#ifndef MARABOUVERIFYTHREAD_H
#define MARABOUVERIFYTHREAD_H

#include "init_python.h"
#include <QObject>
#include <QThread>
#include <QJsonObject>

#define VERIFY_WITH_AR 1
#define VERIFY_WITHOUT_AR 0

class MarabouVerifyThread : public QThread
{
    Q_OBJECT
public:
    explicit MarabouVerifyThread(QObject *parent = nullptr);
    ~MarabouVerifyThread();
    void setParameter(PyObject*, PyObject*, PyObject*, PyObject*, QJsonObject);

signals:
    void SIGNAL_finish_verify(PyObject*, QThread*);

protected:
    void run() override;

private:
    PyObject *origin_net_ = nullptr;
    PyObject *abstract_net_ = nullptr;
    PyObject *abstract_orig_net_ = nullptr;
    PyObject *test_property_ = nullptr;
    QJsonObject parameter_;
};

#endif // MARABOUVERIFYTHREAD_H
