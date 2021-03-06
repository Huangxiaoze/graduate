#ifndef RESULTVIEW_H
#define RESULTVIEW_H

#include <Python.h>
#include <QWidget>
#include "comparerelation.h"
#include "networkgraph.h"
#include <QJsonObject>

namespace Ui {
class ResultView;
}

class ResultView : public QWidget
{
    Q_OBJECT

public:
    explicit ResultView(QWidget *parent = nullptr);
    ~ResultView();
    void parsingJsonFile(QString jsonFile);
    void showCompareRelation();
    void showNetworkGraph();
    // huangxiaoze --- start
    void showNetwork(QJsonObject *jsonObj);
public slots:
    void on_show_network_file(QString filepath);
    void on_show_network(PyObject*);
    // huangxiaoze --- end

    void removeSubTab(int index);
    void on_addNetworkGraph(const QString name, const QString layertype,
                            int layernum, int layerwhich);
    void showlayer(int layer);

signals:
    void updateNetworkNodeStatus(QJsonObject obj);
    void SIGNAL_showlayer(int layer);
private:
    Ui::ResultView *ui;

    CompareRelation * resultGraph = nullptr; // neuron graph
    NetworkGraph *networkGraph = nullptr; // layer graph
    QString lastLayer;
};

#endif // RESULTVIEW_H
