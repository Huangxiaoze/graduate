#include "resultview.h"
#include "ui_resultview.h"
#include "util.h"
#include <QDebug>
#include <QJsonArray>
#include <vector>
#include <cmath>

ResultView::ResultView(QWidget *parent) :
    QWidget(parent),
    ui(new Ui::ResultView)
{
    ui->setupUi(this);
    this->resultGraph =  new CompareRelation();
    this->networkGraph = new NetworkGraph();
    this->showCompareRelation();
    this->showNetworkGraph();
    connect(ui->result,SIGNAL(tabCloseRequested(int)),this,SLOT(removeSubTab(int)));
    connect(this->networkGraph,SIGNAL(SIGNAL_showlayer(int)),this,SLOT(showlayer(int)));
}

void ResultView::showCompareRelation()
{
    if(this->ui->result->indexOf(this->resultGraph) == -1){
        this->ui->result->addTab(this->resultGraph,"Relation");
    }
}

void ResultView::showNetworkGraph()
{
    if(this->ui->result->indexOf(this->networkGraph) == -1){
        this->ui->result->addTab(this->networkGraph,"Layers");
    }
}

void ResultView::showlayer(int layer)
{
    emit SIGNAL_showlayer(layer);
}

void ResultView::on_addNetworkGraph(const QString name, const QString layertype,
                                    int layernum, int layerwhich)
{
    this->showNetworkGraph();
    if(layerwhich==1)
    {
        this->networkGraph->clear();
        this->ui->result->setCurrentWidget(this->networkGraph);
    }
    QString layerinfo;
    QTextStream(&layerinfo)<<layerwhich<<"\nLayer type:\n"<<layertype<<"\nLayer name:\n"<<name<<"\nLayer num:\n"<<layernum;
    this->networkGraph->addNode(layerinfo);
    if (layerwhich>1) this->networkGraph->addEdge(this->lastLayer,layerinfo);
    this->lastLayer=layerinfo;
}

void ResultView::parsingJsonFile(QString jsonFile)
{
    this->resultGraph->clear();
    this->showCompareRelation();
    this->ui->result->setCurrentWidget(this->resultGraph);

    QJsonObject * jsonObj = Util::parseJsonFile(jsonFile);
    if(jsonObj==nullptr) {
        qDebug() << "jsonObj is unvalid";
        return ;
    }
    emit this->updateNetworkNodeStatus(*jsonObj);
    if(jsonObj->contains("graph"))
    {
        QJsonObject graph = jsonObj->value("graph").toObject();
        int nodes = 0;
        if(graph.contains("number_of_nodes")){
            nodes = graph.value("number_of_nodes").toString().toInt();
            for(int i=0;i<nodes;i++)
            {
                //this->resultGraph->addNode(QString::number(i));
            }
        }
        QStringList names;
        int du[nodes+2];
        memset(du,0,sizeof(du));
        int G[nodes+2][nodes+2];
        memset(G,0,sizeof(G));
        if(graph.contains(("names")))
        {
            QJsonValue value = graph.value("names");
            if(value.isArray())
            {
                QJsonArray array = value.toArray();
                int size =array.size();
                for(int i=0;i<size;i++){
                    names.append(array.at(i).toString());
                    this->resultGraph->addNode(array.at(i).toString());
                }
            }
        }

        if(graph.contains("edges"))
        {
            QJsonValue value = graph.value("edges");
            if(value.isArray())
            {
                QJsonArray array = value.toArray();
                int size =array.size();
                for(int i=0;i<size;i++){
                    int indexFrom = array.at(i).toObject().value("from").toString().toInt();
                    int indexTo = array.at(i).toObject().value("to").toString().toInt();
                    this->resultGraph->addEdge(names.at(indexFrom),names.at(indexTo));
                    //qDebug()<<indexFrom<<indexTo;
                    du[indexTo]++;
                    G[indexFrom][indexTo]=1;
                }
            }
        }
//        for(int i=0;i<nodes;i++)
//            for(int j=0;j<nodes;j++)
//                if(G[i][j]!=0)qDebug()<<i<<" "<<j<<" "<<G[i][j];
        //Caution:May cause some dead loop
        //qDebug()<<du[0]<<du[1]<<du[2]<<du[3];
        int posy=0;
        while(true)
        {
            int posx=0;
            for(int i=0;i<nodes;i++)
                if(du[i]==0)
                {
                    this->resultGraph->setpos(names.at(i),posx*40+posy*5,posy*40);
                    //qDebug()<<i<<" "<<posx<<" "<<posy;
                    du[i]=-posy-1;
                    posx++;
                }
            if(posx==0)break;
            for(int i=0;i<nodes;i++)
                if(du[i]==-posy-1)
                {
                    for(int j=0;j<nodes;j++)
                        if(G[i][j]==1)du[j]--;
                }
            posy++;
        }
    }

}



// huangxiaoze--start
void ResultView::on_show_network_file(QString network_filepath)
{
//    return;
    qDebug() << "ResultView::on_show_network: jsonFile = " << network_filepath << endl;
    QJsonObject * jsonObj = Util::parseJsonFile_python(network_filepath);//Util::parseJsonFile(jsonFile);
    this->showNetwork(jsonObj);
}

void ResultView::on_show_network(PyObject* net) {
    QJsonObject *jsonObj = Util::parsePyNetwork(net);
    this->showNetwork(jsonObj);
}


void ResultView::showNetwork(QJsonObject *jsonObj) {
//    return;
//    Util::parseJsonFile_python(jsonFile);
    this->resultGraph->clear();
    this->showCompareRelation();
    this->ui->result->setCurrentWidget(this->resultGraph);

    if(jsonObj==nullptr) {
        qDebug() << "jsonObj is unvalid";
        return ;
    }
    emit this->updateNetworkNodeStatus(*jsonObj);
    if(jsonObj->contains("graph"))
    {
        QJsonObject graph = jsonObj->value("graph").toObject();
        int nodes = 0;
        if(graph.contains("number_of_nodes")){
            nodes = graph.value("number_of_nodes").toString().toInt();
            for(int i=0;i<nodes;i++)
            {
                //this->resultGraph->addNode(QString::number(i));
            }
        }
        QStringList names;
        std::vector<int> du(nodes + 2, 0);
        std::vector< std::vector<int> > G(nodes + 2, std::vector<int>(nodes + 2, 0));

        if(graph.contains(("names")))
        {
            QJsonValue value = graph.value("names");
            if(value.isArray())
            {
                QJsonArray array = value.toArray();
                int size =array.size();
                for(int i=0;i<size;i++){
                    names.append(array.at(i).toString());
                    this->resultGraph->addNode(array.at(i).toString());
                }
            }
        }

        if(graph.contains("edges"))
        {
            QJsonValue value = graph.value("edges");
            if(value.isArray())
            {
                QJsonArray array = value.toArray();
                int size =array.size();
                for(int i=0;i<size;i++){
                    int indexFrom = array.at(i).toObject().value("from").toInt();
                    int indexTo = array.at(i).toObject().value("to").toInt();
//                    qDebug() << "indexFrom=" << indexFrom <<" " << "indexTo=" << indexTo << endl;
                    this->resultGraph->addEdge(names.at(indexFrom),names.at(indexTo));
                    //qDebug()<<indexFrom<<indexTo;
//                    du[indexTo]++;
//                    G[indexFrom][indexTo]=1;
                }
            }
        }
        int max_layer_size = INT_MIN;
        std::map<int, int> layer2size;
        if (jsonObj->contains("layer_sizes")) {
            QJsonValue value = jsonObj->value("layer_sizes");
            if (value.isObject()) {
                QJsonObject layer_sizes = value.toObject();
                qDebug() << layer_sizes << endl;
                for (int i = 0; i < layer_sizes.size(); i++) {
                    auto s = layer_sizes.value(std::to_string(i).c_str());
                    layer2size[i] = s.toInt();
                    max_layer_size = std::max(max_layer_size, s.toInt());
                }
            }
        }
        qDebug() << "max_layer_size" << max_layer_size << endl;
        if(graph.contains(("names")))
        {
            if (graph.contains(("name2pos"))) {
                QJsonValue name_value = graph.value("names");
                QJsonValue pos_value = graph.value("name2pos");
                if(name_value.isArray())
                {
                    QJsonArray array = name_value.toArray();
                    if (pos_value.isObject()) {
                        QJsonObject pos_obj = pos_value.toObject();
                        int size =array.size();
                        for(int i=0;i<size;i++){
                            auto name = array.at(i).toString();
                            auto pos = pos_obj.value(name).toObject();
                            int x = pos.value("x").toInt();
                            int y = pos.value("y").toInt();
//                            qDebug() << "x=" << x << ", " << "y=" << y << endl;
                            this->resultGraph->setpos(name, x * 3000, max_layer_size * (y + 1) / (layer2size[x] + 1) * 500);
                        }
                    }
            }
            }
        }
    }
    this->resultGraph->showMaximized();
    QPixmap screen = QPixmap::grabWidget(this->resultGraph);
    screen.save("./page.png");

}
// huangxiaoze--end


void ResultView::removeSubTab(int index)
{
    this->ui->result->removeTab(index);
}
ResultView::~ResultView()
{
    delete ui;
}
