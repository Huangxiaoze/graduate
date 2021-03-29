#ifndef MARABOU_H
#define MARABOU_H

#include "project.h"
#include "marabouverifythread.h"

#include <QWidget>
#include <QString>
#include <QJsonObject>
#include <QSlider>
#include <QDoubleSpinBox>

namespace Ui {
class Marabou;
}

class Marabou : public QWidget
{
    Q_OBJECT

public:
    explicit Marabou(Project* project, QWidget *parent = nullptr);
    ~Marabou();
signals:
    void SIGNAL_import_network(QString);
    void SIGNAL_run_abstract(QJsonObject);
    void SIGNAL_verify_by_marabou(QJsonObject);
public slots:
    void on_import_network();
    void on_run_abstract();
    void on_as_slider_valueChange(int);
    void on_rs_slider_valudeChange(int);
    void on_verify_without_ar();
    void on_verify_with_ar();
    void on_planet_with_ar();
    void on_planet_without_ar();
    void on_change_abstract_parameter();
    void on_abstract_finished();
    void changeInputX0SpinboxValue(int);
    void changeInputX0SlideValue(double);
    void changeInputX1SpinboxValue(int);
    void changeInputX1SlideValue(double);
    void changeInputX2SpinboxValue(int);
    void changeInputX2SlideValue(double);
    void changeInputX3SpinboxValue(int);
    void changeInputX3SlideValue(double);
    void changeInputX4SpinboxValue(int);
    void changeInputX4SlideValue(double);
    void changeDeltaSpinbox(int);
    void changeDeltaSlider(double);
    void on_show_verify_result(QString);
    void resetResultStatus();
    void on_dump_rlv();
private:
    QJsonObject getParameter();
    void connect_S_L();
    Ui::Marabou *ui;
    Project *project = nullptr;

    QSlider* sliders[5];
    QDoubleSpinBox* dsboxs[5];
};

#endif // MARABOU_H
