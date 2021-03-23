#include "marabou.h"
#include "ui_marabou.h"
#include <QFileDialog>
#include <QMessageBox>
#include <iostream>
#include <QDebug>
#include <QJsonObject>

Marabou::Marabou(Project *project, QWidget *parent) :
    QWidget(parent),
    ui(new Ui::Marabou)
{
    ui->setupUi(this);
    this->project = project;

    for (int i = 0;i < 5; i++) {
        QHBoxLayout *layout = new QHBoxLayout();
        QLabel *label = new QLabel(QString("inputX%1").arg(i));
        QSlider *slider = new QSlider();
        QDoubleSpinBox *dsbox = new QDoubleSpinBox();

        sliders[i] = slider;
        dsboxs[i] = dsbox;

        slider->setOrientation(Qt::Horizontal);
        slider->setSingleStep(1);
        dsbox->setDecimals(3);
        dsbox->setSingleStep(0.001);
        if (i == 0) {
            dsbox->setRange(-0.328, 0.679);
            slider->setRange(-328, 679);
        } else {
            dsbox->setRange(-0.500, 0.500);
            slider->setRange(-500, 500);
        }
        layout->addWidget(label);
        layout->addWidget(slider);
        layout->addWidget(dsbox);
        this->ui->input_vlayout->addLayout(layout);
    }

    connect(sliders[0], SIGNAL(valueChanged(int)), this, SLOT(changeInputX0SpinboxValue(int)));
    connect(dsboxs[0], SIGNAL(valueChanged(double)), this, SLOT(changeInputX0SlideValue(double)));

    connect(sliders[1], SIGNAL(valueChanged(int)), this, SLOT(changeInputX1SpinboxValue(int)));
    connect(dsboxs[1], SIGNAL(valueChanged(double)), this, SLOT(changeInputX1SlideValue(double)));

    connect(sliders[2], SIGNAL(valueChanged(int)), this, SLOT(changeInputX2SpinboxValue(int)));
    connect(dsboxs[2], SIGNAL(valueChanged(double)), this, SLOT(changeInputX2SlideValue(double)));

    connect(sliders[3], SIGNAL(valueChanged(int)), this, SLOT(changeInputX3SpinboxValue(int)));
    connect(dsboxs[3], SIGNAL(valueChanged(double)), this, SLOT(changeInputX3SlideValue(double)));

    connect(sliders[4], SIGNAL(valueChanged(int)), this, SLOT(changeInputX4SpinboxValue(int)));
    connect(dsboxs[4], SIGNAL(valueChanged(double)), this, SLOT(changeInputX4SlideValue(double)));

    connect(this->ui->delta_slider, SIGNAL(valueChanged(int)), this, SLOT(changeDeltaSpinbox(int)));
    connect(this->ui->delta_spinbox, SIGNAL(valueChanged(double)), this, SLOT(changeDeltaSlider(double)));

    qDebug() << "Marabou" << endl;
    connect_S_L();
}

Marabou::~Marabou()
{
    delete ui;
}

void Marabou::changeDeltaSpinbox(int value) {
    this->ui->delta_spinbox->setValue(1.0 * value / 100);
}

void Marabou::changeDeltaSlider(double value) {
    this->ui->delta_slider->setValue(int(value * 100));
}



void Marabou::changeInputX0SpinboxValue(int v) {
    dsboxs[0]->setValue(1.0*v / 1000);
}
void Marabou::changeInputX0SlideValue(double v) {
    sliders[0]->setValue(int(1000*v));
}

void Marabou::changeInputX1SpinboxValue(int v) {
    dsboxs[1]->setValue(1.0*v / 1000);
}
void Marabou::changeInputX1SlideValue(double v) {
    sliders[1]->setValue(int(1000*v));
}

void Marabou::changeInputX2SpinboxValue(int v) {
    dsboxs[2]->setValue(1.0*v / 1000);
}
void Marabou::changeInputX2SlideValue(double v) {
    sliders[2]->setValue(int(1000*v));
}

void Marabou::changeInputX3SpinboxValue(int v) {
    dsboxs[3]->setValue(1.0*v / 1000);
}
void Marabou::changeInputX3SlideValue(double v) {
    sliders[3]->setValue(int(1000*v));
}

void Marabou::changeInputX4SpinboxValue(int v) {
    dsboxs[4]->setValue(1.0*v / 1000);
}
void Marabou::changeInputX4SlideValue(double v) {
    sliders[4]->setValue(int(1000*v));
}




void Marabou::connect_S_L() {
    connect(this->ui->importNetwork, SIGNAL(clicked()), this, SLOT(on_import_network()));
    connect(this->ui->run_abstract, SIGNAL(clicked()), this, SLOT(on_run_abstract()));
    connect(this->ui->abstraction_sequence_slider, SIGNAL(valueChanged(int)), this, SLOT(on_as_slider_valueChange(int)));
    connect(this->ui->verify_without_ar, SIGNAL(clicked()), this, SLOT(on_verify_without_ar()));
    connect(this->ui->verify_with_ar, SIGNAL(clicked()), this, SLOT(on_verify_with_ar()));
    connect(this->ui->refinement_sequence_slider, SIGNAL(valueChanged(int)), this, SLOT(on_rs_slider_valueChange(int)));

    connect(this->ui->verify_with_ar, SIGNAL(clicked()), this, SLOT(resetResultStatus()));
    connect(this->ui->verify_without_ar, SIGNAL(clicked()), this, SLOT(resetResultStatus()));

    // ensure abstract has finished when change the abstract parameter
    connect(this->ui->abstraction_sequence_slider, SIGNAL(valueChanged(int)), this, SLOT(on_change_abstract_parameter()));
    connect(this->ui->abstract_type_combobox, SIGNAL(currentTextChanged(const QString &)), this, SLOT(on_change_abstract_parameter()));
    connect(this->ui->property_combobox, SIGNAL(currentTextChanged(const QString &)), this, SLOT(on_change_abstract_parameter()));
}

void Marabou::on_import_network() {
    QString file = QFileDialog::getOpenFileName(this,tr("Choose Network File"), this->project->getPath());
    if (!file.isEmpty()) {
        this->ui->network_lineEdit->setText(file);
        emit SIGNAL_import_network(file);
    }
}

void Marabou::on_run_abstract() {
    QJsonObject parameter = getParameter();
    QString file = parameter.value("filepath").toString();
    if (file.isEmpty()) {
        QMessageBox::warning(this, "Warning", "Please select Network file.");
        return;
    }
    emit SIGNAL_run_abstract(parameter);
}

void Marabou::on_as_slider_valueChange(int value) {
    this->ui->as_value->setText(QString("%1").arg(value));
}

void Marabou::on_rs_slider_valudeChange(int value) {
    this->ui->rs_value->setText(QString("%1").arg(value));
}

void Marabou::on_verify_without_ar() {
    QJsonObject parameter = getParameter();
    QString file = parameter.value("filepath").toString();
    if (file.isEmpty()) {
        QMessageBox::warning(this, "Warning", "Please select Network file.");
        return;
    }
    parameter["verify_mode"] = VERIFY_WITHOUT_AR;
    emit SIGNAL_verify_by_marabou(parameter);
}

void Marabou::on_verify_with_ar() {
    QJsonObject parameter = getParameter();
    QString file = parameter.value("filepath").toString();
    if (file.isEmpty()) {
        QMessageBox::warning(this, "Warning", "Please select Network file.");
        return;
    }
    parameter["verify_mode"] = VERIFY_WITH_AR;
    emit SIGNAL_verify_by_marabou(parameter);
}

QJsonObject Marabou::getParameter() {
    QString file = this->ui->network_lineEdit->text();
    QString abstract_type = this->ui->abstract_type_combobox->currentText();
    QString refinement_type = this->ui->refinement_type_combobox->currentText();
    QString as = QString("%1").arg(this->ui->abstraction_sequence_slider->value());
    QString rs = this->ui->rs_value->text();
    QString property = this->ui->property_combobox->currentText();
    QJsonObject parameter;
    parameter["filepath"] = file;
    parameter["abstract_type"] = abstract_type;
    parameter["abstraction_sequence"] = as;
    parameter["refinement_sequence"] = rs;
    parameter["property_id"] = property;
    parameter["refinement_type"] = refinement_type;

    for (int i = 0; i < 5; i++) {
        QString name = QString("inputX%1").arg(i);
        parameter[name] = this->dsboxs[i]->value();
    }

    parameter["delta"] = this->ui->delta_spinbox->value();
    parameter["output_label"] = this->ui->output_combobox->currentText();
    return parameter;
}

void Marabou::on_change_abstract_parameter() {
    this->ui->verify_with_ar->setDisabled(true);
}

void Marabou::on_abstract_finished() {
    this->ui->verify_with_ar->setDisabled(false);
}

void Marabou::resetResultStatus() {
    this->ui->result_label->setPixmap(QPixmap(":/resources/off.gif"));
}

void Marabou::on_show_verify_result(QString res) {
    if (res == "UNSAT") {
        this->ui->result_label->setPixmap(QPixmap(":/resources/unsat.gif"));
    } else {
        this->ui->result_label->setPixmap(QPixmap(":/resources/sat.gif"));
    }
}
