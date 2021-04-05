QT       += core gui

greaterThan(QT_MAJOR_VERSION, 4): QT += widgets

CONFIG += c++11

QMAKE_LFLAGS += -no-pie

# The following define makes your compiler emit warnings if you use
# any Qt feature that has been marked deprecated (the exact warnings
# depend on your compiler). Please consult the documentation of the
# deprecated API in order to know how to port your code away from it.
DEFINES += QT_DEPRECATED_WARNINGS

# You can also make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
# You can also select to disable deprecated APIs only up to a certain version of Qt.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

SOURCES += \
    backend.cpp \
    choose.cpp \
    comparerelation.cpp \
    configueproject.cpp \
    configurationview.cpp \
    deepgcfg.cpp \
    edge.cpp \
    file.cpp \
    graphwidget.cpp \
    highlighter.cpp \
    loadingwidget.cpp \
    main.cpp \
    mainui.cpp \
    marabou.cpp \
    matrix.cpp \
    network.cpp \
    networkfile.cpp \
    networkgraph.cpp \
    networklayer.cpp \
    networklayerdata.cpp \
    node.cpp \
    outview.cpp \
    project.cpp \
    projectitem.cpp \
    projectmodel.cpp \
    projectview.cpp \
    reluplexcfg.cpp \
    resultview.cpp \
    selectdialog.cpp \
    settingview.cpp \
    textedit.cpp \
    treenode.cpp \
    updatenetworkthread.cpp \
    util.cpp \
    verifythread.cpp

HEADERS += \
    backend.h \
    choose.h \
    comparerelation.h \
    configueproject.h \
    configurationview.h \
    deepgcfg.h \
    edge.h \
    file.h \
    graphwidget.h \
    highlighter.h \
    init_python.h \
    loadingwidget.h \
    mainui.h \
    marabou.h \
    matrix.h \
    network.h \
    networkfile.h \
    networkgraph.h \
    networklayer.h \
    networklayerdata.h \
    node.h \
    outview.h \
    project.h \
    projectitem.h \
    projectmodel.h \
    projectview.h \
    reluplexcfg.h \
    resultview.h \
    selectdialog.h \
    settingview.h \
    textedit.h \
    treenode.h \
    updatenetworkthread.h \
    util.h \
    verifythread.h

FORMS += \
    choose.ui \
    comparerelation.ui \
    configueproject.ui \
    configurationview.ui \
    deepgcfg.ui \
    loadingwidget.ui \
    mainui.ui \
    marabou.ui \
    matrix.ui \
    network.ui \
    networkgraph.ui \
    networklayer.ui \
    outview.ui \
    projectview.ui \
    reluplexcfg.ui \
    resultview.ui \
    selectdialog.ui \
    settingview.ui

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

DISTFILES += \
    core/__init__.py \
    core/__pycache__/__init__.cpython-38.pyc \
    core/abstraction/__init__.py \
    core/abstraction/__pycache__/__init__.cpython-38.pyc \
    core/abstraction/__pycache__/alg2.cpython-38.pyc \
    core/abstraction/__pycache__/naive.cpython-38.pyc \
    core/abstraction/__pycache__/random_abstract.cpython-38.pyc \
    core/abstraction/__pycache__/step.cpython-38.pyc \
    core/abstraction/alg2.py \
    core/abstraction/naive.py \
    core/abstraction/random_abstract.py \
    core/abstraction/step.py \
    core/ar_module_all_code_2019.py \
    core/configuration/__init__.py \
    core/configuration/__pycache__/__init__.cpython-38.pyc \
    core/configuration/__pycache__/consts.cpython-38.pyc \
    core/configuration/consts.py \
    core/configuration/consts_orig.py \
    core/data_structures/ARNode.py \
    core/data_structures/Edge.py \
    core/data_structures/Layer.py \
    core/data_structures/Network.py \
    core/data_structures/__init__.py \
    core/data_structures/__pycache__/ARNode.cpython-38.pyc \
    core/data_structures/__pycache__/Edge.cpython-38.pyc \
    core/data_structures/__pycache__/Layer.cpython-38.pyc \
    core/data_structures/__pycache__/Network.cpython-38.pyc \
    core/data_structures/__pycache__/__init__.cpython-38.pyc \
    core/nnet/__init__.py \
    core/nnet/__pycache__/__init__.cpython-38.pyc \
    core/nnet/__pycache__/read_nnet.cpython-38.pyc \
    core/nnet/read_nnet.py \
    core/pre_process/__init__.py \
    core/pre_process/__pycache__/__init__.cpython-38.pyc \
    core/pre_process/__pycache__/pre_process.cpython-38.pyc \
    core/pre_process/__pycache__/split_inc_dec.cpython-38.pyc \
    core/pre_process/__pycache__/split_pos_neg.cpython-38.pyc \
    core/pre_process/pre_process.py \
    core/pre_process/split_inc_dec.py \
    core/pre_process/split_pos_neg.py \
    core/prodeep/__init__.py \
    core/prodeep/prodeep.py \
    core/refinement/__init__.py \
    core/refinement/__pycache__/__init__.cpython-38.pyc \
    core/refinement/__pycache__/refine.cpython-38.pyc \
    core/refinement/__pycache__/step.cpython-38.pyc \
    core/refinement/cegar.py \
    core/refinement/cetar.py \
    core/refinement/refine.py \
    core/refinement/step.py \
    core/utils/__init__.py \
    core/utils/__pycache__/__init__.cpython-38.pyc \
    core/utils/__pycache__/abstraction_utils.cpython-38.pyc \
    core/utils/__pycache__/activation_functions.cpython-38.pyc \
    core/utils/__pycache__/alg2_utils.cpython-38.pyc \
    core/utils/__pycache__/ar_utils.cpython-38.pyc \
    core/utils/__pycache__/assertions_utils.cpython-38.pyc \
    core/utils/__pycache__/debug_utils.cpython-38.pyc \
    core/utils/__pycache__/marabou_query_utils.cpython-38.pyc \
    core/utils/__pycache__/verification_properties_utils.cpython-38.pyc \
    core/utils/abstraction_utils.py \
    core/utils/activation_functions.py \
    core/utils/alg2_utils.py \
    core/utils/ar_utils.py \
    core/utils/assertions_utils.py \
    core/utils/debug_utils.py \
    core/utils/marabou_query_utils.py \
    core/utils/parse_utils.py \
    core/utils/verification_properties_utils.py \
    core/utils/verification_properties_utils_orig.py \
    core/visualization/__init__.py \
    core/visualization/__pycache__/__init__.cpython-38.pyc \
    core/visualization/__pycache__/visualize_network.cpython-38.pyc \
    core/visualization/visualize_network.py \
    experiments/__init__.py \
    experiments/__pycache__/__init__.cpython-38.pyc \
    experiments/__pycache__/consts.cpython-38.pyc \
    experiments/collect/__init__.py \
    experiments/collect/analyze.py \
    experiments/collect/unify_experiments_results.py \
    experiments/collect/validate_equal_results.py \
    experiments/consts.py \
    experiments/dev_exp_results_archive/df_experiment__NN_ACASXU_run2a_1_1_batch_2000.nnet__PID_adversarial_0__M_marabou_with_ar__R_cegar__A_complete__RS_50__AS_100__DATETIME_2021-03-08_19:19:26 \
    experiments/dev_exp_results_archive/df_experiment__NN_ACASXU_run2a_1_1_batch_2000.nnet__PID_adversarial_0__M_marabou_with_ar__R_cegar__A_complete__RS_50__AS_100__DATETIME_2021-03-08_20:11:18 \
    experiments/dev_exp_results_archive/df_experiment__NN_ACASXU_run2a_1_1_batch_2000.nnet__PID_adversarial_0__M_marabou_with_ar__R_cegar__A_complete__RS_50__AS_100__DATETIME_2021-03-08_20:12:57 \
    experiments/dev_exp_results_archive/df_experiment__NN_ACASXU_run2a_1_1_batch_2000.nnet__PID_adversarial_0__M_marabou_with_ar__R_cegar__A_complete__RS_50__AS_100__DATETIME_2021-03-08_20:13:18 \
    experiments/dev_exp_results_archive/df_experiment__NN_ACASXU_run2a_1_1_batch_2000.nnet__PID_adversarial_0__M_marabou_with_ar__R_cegar__A_complete__RS_50__AS_100__DATETIME_2021-03-08_20:14:10 \
    experiments/dev_exp_results_archive/df_experiment__NN_ACASXU_run2a_1_1_batch_2000.nnet__PID_adversarial_0__M_marabou_with_ar__R_cegar__A_complete__RS_50__AS_100__DATETIME_2021-03-08_20:14:53 \
    experiments/dev_exp_results_archive/df_experiment__NN_ACASXU_run2a_1_1_batch_2000.nnet__PID_adversarial_0__M_marabou_with_ar__R_cegar__A_complete__RS_50__AS_100__DATETIME_2021-03-08_20:15:40 \
    experiments/dev_exp_results_archive/df_experiment__NN_ACASXU_run2a_1_1_batch_2000.nnet__PID_adversarial_0__M_marabou_with_ar__R_cegar__A_complete__RS_50__AS_100__DATETIME_2021-03-08_20:17:14 \
    experiments/dev_exp_results_archive/df_experiment__NN_ACASXU_run2a_1_1_batch_2000.nnet__PID_adversarial_0__M_marabou_with_ar__R_cegar__A_complete__RS_50__AS_100__DATETIME_2021-03-08_20:18:26 \
    experiments/dev_exp_results_archive/df_experiment__NN_ACASXU_run2a_1_1_batch_2000.nnet__PID_adversarial_0__M_marabou_with_ar__R_cegar__A_complete__RS_50__AS_100__DATETIME_2021-03-08_20:19:55 \
    experiments/dev_exp_results_archive/df_experiment__NN_ACASXU_run2a_1_1_batch_2000.nnet__PID_adversarial_0__M_marabou_with_ar__R_cegar__A_complete__RS_50__AS_100__DATETIME_2021-03-08_20:26:28 \
    experiments/dev_exp_results_archive/df_experiment__NN_ACASXU_run2a_1_2_batch_2000.nnet__PID_adversarial_0__M_marabou_with_ar__R_cegar__A_complete__RS_50__AS_100__DATETIME_2021-02-20_14:38:02 \
    experiments/dev_exp_results_archive/df_experiment__NN_ACASXU_run2a_1_2_batch_2000.nnet__PID_adversarial_0__M_marabou_with_ar__R_cegar__A_complete__RS_50__AS_100__DATETIME_2021-03-08_19:20:01 \
    experiments/dev_exp_results_archive/df_experiment__NN_ACASXU_run2a_1_2_batch_2000.nnet__PID_adversarial_0__M_marabou_with_ar__R_cegar__A_complete__RS_50__AS_100__DATETIME_2021-03-08_20:18:01 \
    experiments/dev_exp_results_archive/df_experiment__NN_ACASXU_run2a_1_2_batch_2000.nnet__PID_adversarial_0__M_marabou_with_ar__R_cegar__A_complete__RS_50__AS_100__DATETIME_2021-03-08_20:20:19 \
    experiments/dev_exp_results_archive/df_experiment__NN_ACASXU_run2a_1_2_batch_2000.nnet__PID_adversarial_0__M_marabou_with_ar__R_cegar__A_complete__RS_50__AS_100__DATETIME_2021-03-08_20:23:15 \
    experiments/dev_exp_results_archive/df_experiment__NN_ACASXU_run2a_1_2_batch_2000.nnet__PID_adversarial_0__M_marabou_with_ar__R_cegar__A_complete__RS_50__AS_100__DATETIME_2021-03-08_20:26:44 \
    experiments/dev_exp_results_archive/df_experiment__NN_ACASXU_run2a_1_2_batch_2000.nnet__PID_adversarial_0__M_marabou_with_ar__R_cegar__A_complete__RS_50__AS_100__DATETIME_2021-03-08_21:55:06 \
    experiments/dev_exp_results_archive/df_experiment__NN_ACASXU_run2a_1_2_batch_2000.nnet__PID_adversarial_0__M_marabou_with_ar__R_cegar__A_complete__RS_50__AS_100__DATETIME_2021-03-08_22:01:01 \
    experiments/dev_exp_results_archive/df_experiment__NN_ACASXU_run2a_1_2_batch_2000.nnet__PID_adversarial_0__M_marabou_with_ar__R_cegar__A_complete__RS_50__AS_100__DATETIME_2021-03-08_22:07:15 \
    experiments/dev_exp_results_archive/df_experiment__NN_ACASXU_run2a_1_2_batch_2000.nnet__PID_adversarial_0__M_marabou_with_ar__R_cegar__A_complete__RS_50__AS_100__DATETIME_2021-03-08_22:08:11 \
    experiments/dev_exp_results_archive/df_experiment__NN_ACASXU_run2a_1_2_batch_2000.nnet__PID_adversarial_0__M_marabou_with_ar__R_cegar__A_complete__RS_50__AS_100__DATETIME_2021-03-08_23:09:22 \
    experiments/dev_exp_results_archive/df_experiment__NN_ACASXU_run2a_1_2_batch_2000.nnet__PID_adversarial_0__M_marabou_with_ar__R_cegar__A_complete__RS_50__AS_100__DATETIME_2021-03-08_23:58:24 \
    experiments/dev_exp_results_archive/df_experiment__NN_ACASXU_run2a_1_2_batch_2000.nnet__PID_adversarial_0__M_marabou_with_ar__R_cegar__A_complete__RS_50__AS_100__DATETIME_2021-03-09_20:55:09 \
    experiments/dev_exp_results_archive/df_experiment__NN_ACASXU_run2a_1_3_batch_2000.nnet__PID_adversarial_0__M_marabou_with_ar__R_cegar__A_complete__RS_50__AS_100__DATETIME_2021-03-08_19:20:16 \
    experiments/dev_exp_results_archive/df_experiment__NN_ACASXU_run2a_1_3_batch_2000.nnet__PID_adversarial_0__M_marabou_with_ar__R_cegar__A_complete__RS_50__AS_100__DATETIME_2021-03-08_19:20:52 \
    experiments/dev_exp_results_archive/df_experiment__NN_ACASXU_run2a_1_3_batch_2000.nnet__PID_adversarial_0__M_marabou_with_ar__R_cegar__A_complete__RS_50__AS_100__DATETIME_2021-03-08_19:29:13 \
    experiments/dev_exp_results_archive/df_experiment__NN_ACASXU_run2a_1_3_batch_2000.nnet__PID_adversarial_0__M_marabou_with_ar__R_cegar__A_complete__RS_50__AS_100__DATETIME_2021-03-08_20:26:53 \
    experiments/dev_exp_results_archive/df_experiment__NN_ACASXU_run2a_1_4_batch_2000.nnet__PID_adversarial_0__M_marabou_with_ar__R_cegar__A_complete__RS_50__AS_100__DATETIME_2021-03-08_20:27:02 \
    experiments/dev_exp_results_archive/df_experiment__NN_ACASXU_run2a_1_5_batch_2000.nnet__PID_adversarial_0__M_marabou_with_ar__R_cegar__A_complete__RS_50__AS_100__DATETIME_2021-03-08_20:27:10 \
    experiments/dev_exp_results_archive/df_experiment__NN_ACASXU_run2a_1_6_batch_2000.nnet__PID_adversarial_0__M_marabou_with_ar__R_cegar__A_complete__RS_50__AS_100__DATETIME_2021-03-08_20:27:19 \
    experiments/dev_exp_results_archive/df_experiment__NN_ACASXU_run2a_1_8_batch_2000.nnet__PID_adversarial_0__M_marabou_with_ar__R_cegar__A_complete__RS_50__AS_100__DATETIME_2021-03-08_20:50:48 \
    experiments/dev_exp_results_archive/df_experiment__NN_ACASXU_run2a_1_9_batch_2000.nnet__PID_adversarial_0__M_marabou_with_ar__R_cegar__A_complete__RS_50__AS_100__DATETIME_2021-03-08_20:51:06 \
    experiments/dev_exp_results_archive/df_experiment__NN_ACASXU_run2a_2_1_batch_2000.nnet__PID_adversarial_0__M_marabou_with_ar__R_cegar__A_complete__RS_50__AS_100__DATETIME_2021-03-08_20:51:13 \
    experiments/dev_exp_results_archive/df_experiment__NN_ACASXU_run2a_2_2_batch_2000.nnet__PID_adversarial_0__M_marabou_with_ar__R_cegar__A_complete__RS_50__AS_100__DATETIME_2021-03-08_20:51:20 \
    experiments/dev_exp_results_archive/df_experiment__NN_ACASXU_run2a_2_3_batch_2000.nnet__PID_adversarial_0__M_marabou_with_ar__R_cegar__A_complete__RS_50__AS_100__DATETIME_2021-03-08_19:29:38 \
    experiments/dev_exp_results_archive/df_experiment__NN_ACASXU_run2a_2_3_batch_2000.nnet__PID_adversarial_0__M_marabou_with_ar__R_cegar__A_complete__RS_50__AS_100__DATETIME_2021-03-08_20:51:27 \
    experiments/dev_exp_results_archive/df_experiment__NN_ACASXU_run2a_2_5_batch_2000.nnet__PID_adversarial_0__M_marabou_with_ar__R_cegar__A_complete__RS_50__AS_100__DATETIME_2021-03-08_19:30:17 \
    experiments/dev_exp_results_archive/df_experiment__NN_ACASXU_run2a_2_5_batch_2000.nnet__PID_adversarial_0__M_marabou_with_ar__R_cegar__A_complete__RS_50__AS_100__DATETIME_2021-03-08_19:32:53 \
    experiments/dev_exp_results_archive/df_experiment__NN_ACASXU_run2a_2_5_batch_2000.nnet__PID_adversarial_0__M_marabou_with_ar__R_cegar__A_complete__RS_50__AS_100__DATETIME_2021-03-08_19:35:04 \
    experiments/dev_exp_results_archive/df_experiment__NN_ACASXU_run2a_2_5_batch_2000.nnet__PID_adversarial_0__M_marabou_with_ar__R_cegar__A_complete__RS_50__AS_100__DATETIME_2021-03-08_19:39:48 \
    experiments/dev_exp_results_archive/df_experiment__NN_ACASXU_run2a_2_5_batch_2000.nnet__PID_adversarial_0__M_marabou_with_ar__R_cegar__A_complete__RS_50__AS_100__DATETIME_2021-03-08_19:52:33 \
    experiments/dev_exp_results_archive/df_experiment__NN_ACASXU_run2a_2_5_batch_2000.nnet__PID_adversarial_0__M_marabou_with_ar__R_cegar__A_complete__RS_50__AS_100__DATETIME_2021-03-08_19:53:32 \
    experiments/dev_exp_results_archive/df_experiment__NN_ACASXU_run2a_2_8_batch_2000.nnet__PID_adversarial_0__M_marabou_with_ar__R_cegar__A_complete__RS_50__AS_100__DATETIME_2021-02-19_22:57:07 \
    experiments/dev_exp_results_archive/df_experiment__NN_ACASXU_run2a_2_8_batch_2000.nnet__PID_adversarial_0__M_marabou_with_ar__R_cegar__A_complete__RS_50__AS_100__DATETIME_2021-02-20_14:31:56 \
    experiments/dev_exp_results_archive/df_experiment__NN_ACASXU_run2a_2_8_batch_2000.nnet__PID_adversarial_0__M_marabou_with_ar__R_cegar__A_complete__RS_50__AS_100__DATETIME_2021-02-28_18:22:43 \
    experiments/dev_exp_results_archive/df_experiment__NN_ACASXU_run2a_2_8_batch_2000.nnet__PID_adversarial_0__M_marabou_with_ar__R_cegar__A_complete__RS_50__AS_100__DATETIME_2021-02-28_19:50:49 \
    experiments/dev_exp_results_archive/df_experiment__NN_ACASXU_run2a_2_8_batch_2000.nnet__PID_adversarial_0__M_marabou_with_ar__R_cegar__A_complete__RS_50__AS_100__DATETIME_2021-02-28_20:28:38 \
    experiments/dev_exp_results_archive/df_experiment__NN_ACASXU_run2a_2_8_batch_2000.nnet__PID_adversarial_0__M_marabou_with_ar__R_cegar__A_complete__RS_50__AS_100__DATETIME_2021-02-28_20:41:17 \
    experiments/dev_exp_results_archive/df_experiment__NN_ACASXU_run2a_2_8_batch_2000.nnet__PID_adversarial_0__M_marabou_with_ar__R_cegar__A_complete__RS_50__AS_100__DATETIME_2021-03-06_14:41:18 \
    experiments/dev_exp_results_archive/df_experiment__NN_ACASXU_run2a_2_8_batch_2000.nnet__PID_adversarial_0__M_marabou_with_ar__R_cegar__A_complete__RS_50__AS_100__DATETIME_2021-03-06_14:43:11 \
    experiments/dev_exp_results_archive/df_experiment__NN_ACASXU_run2a_2_8_batch_2000.nnet__PID_adversarial_0__M_marabou_with_ar__R_cegar__A_complete__RS_50__AS_100__DATETIME_2021-03-06_15:08:03 \
    experiments/dev_exp_results_archive/df_experiment__NN_ACASXU_run2a_2_8_batch_2000.nnet__PID_adversarial_0__M_marabou_with_ar__R_cegar__A_complete__RS_50__AS_100__DATETIME_2021-03-06_15:25:14 \
    experiments/dev_exp_results_archive/df_experiment__NN_ACASXU_run2a_2_8_batch_2000.nnet__PID_adversarial_0__M_marabou_with_ar__R_cegar__A_complete__RS_50__AS_100__DATETIME_2021-03-06_15:25:51 \
    experiments/dev_exp_results_archive/df_experiment__NN_ACASXU_run2a_2_8_batch_2000.nnet__PID_adversarial_0__M_marabou_with_ar__R_cegar__A_complete__RS_50__AS_100__DATETIME_2021-03-06_15:26:55 \
    experiments/dev_exp_results_archive/df_experiment__NN_ACASXU_run2a_2_8_batch_2000.nnet__PID_adversarial_0__M_marabou_with_ar__R_cegar__A_complete__RS_50__AS_100__DATETIME_2021-03-06_16:00:38 \
    experiments/dev_exp_results_archive/df_experiment__NN_ACASXU_run2a_2_8_batch_2000.nnet__PID_adversarial_0__M_marabou_with_ar__R_cegar__A_complete__RS_50__AS_100__DATETIME_2021-03-06_16:29:18 \
    experiments/dev_exp_results_archive/df_experiment__NN_ACASXU_run2a_2_8_batch_2000.nnet__PID_adversarial_0__M_marabou_with_ar__R_cegar__A_complete__RS_50__AS_100__DATETIME_2021-03-08_17:03:14 \
    experiments/dev_exp_results_archive/df_experiment__NN_ACASXU_run2a_2_8_batch_2000.nnet__PID_adversarial_0__M_marabou_with_ar__R_cegar__A_complete__RS_50__AS_100__DATETIME_2021-03-08_17:05:08 \
    experiments/dev_exp_results_archive/df_experiment__NN_ACASXU_run2a_2_8_batch_2000.nnet__PID_adversarial_0__M_marabou_with_ar__R_cegar__A_complete__RS_50__AS_100__DATETIME_2021-03-08_17:07:42 \
    experiments/dev_exp_results_archive/df_experiment__NN_ACASXU_run2a_2_8_batch_2000.nnet__PID_adversarial_0__M_marabou_with_ar__R_cegar__A_complete__RS_50__AS_100__DATETIME_2021-03-08_17:17:59 \
    experiments/dev_exp_results_archive/df_experiment__NN_ACASXU_run2a_2_8_batch_2000.nnet__PID_adversarial_0__M_marabou_with_ar__R_cegar__A_complete__RS_50__AS_100__DATETIME_2021-03-08_17:19:50 \
    experiments/dev_exp_results_archive/df_experiment__NN_ACASXU_run2a_2_8_batch_2000.nnet__PID_adversarial_0__M_marabou_with_ar__R_cegar__A_complete__RS_50__AS_100__DATETIME_2021-03-08_18:54:30 \
    experiments/dev_exp_results_archive/df_experiment__NN_ACASXU_run2a_2_8_batch_2000.nnet__PID_adversarial_0__M_marabou_with_ar__R_cegar__A_complete__RS_50__AS_100__DATETIME_2021-03-08_18:56:20 \
    experiments/dev_exp_results_archive/df_experiment__NN_ACASXU_run2a_2_8_batch_2000.nnet__PID_adversarial_0__M_marabou_with_ar__R_cegar__A_complete__RS_50__AS_100__DATETIME_2021-03-08_18:57:27 \
    experiments/dev_exp_results_archive/df_experiment__NN_ACASXU_run2a_2_8_batch_2000.nnet__PID_adversarial_0__M_marabou_with_ar__R_cegar__A_complete__RS_50__AS_100__DATETIME_2021-03-08_19:05:16 \
    experiments/dev_exp_results_archive/df_experiment__NN_ACASXU_run2a_2_8_batch_2000.nnet__PID_adversarial_0__M_marabou_with_ar__R_cegar__A_complete__RS_50__AS_100__DATETIME_2021-03-08_19:12:52 \
    experiments/dev_exp_results_archive/df_experiment__NN_ACASXU_run2a_2_8_batch_2000.nnet__PID_adversarial_0__M_marabou_with_ar__R_cegar__A_complete__RS_50__AS_100__DATETIME_2021-03-08_19:16:30 \
    experiments/dev_exp_results_archive/df_experiment__NN_ACASXU_run2a_2_8_batch_2000.nnet__PID_adversarial_0__M_marabou_with_ar__R_cegar__A_complete__RS_50__AS_100__DATETIME_2021-03-08_19:18:32 \
    experiments/dev_exp_results_archive/df_experiment__NN_ACASXU_run2a_2_8_batch_2000.nnet__PID_adversarial_0__M_marabou_with_ar__R_cegar__A_complete__RS_50__AS_100__DATETIME_2021-03-08_20:09:08 \
    experiments/dev_exp_results_archive/df_experiment__NN_ACASXU_run2a_5_7_batch_2000.nnet__PID_basic_2__M_marabou__R_cegar__A_complete__RS_50__AS_100__DATETIME_2021-02-20_15:29:03 \
    experiments/dev_exp_results_archive/df_experiment__NN_ACASXU_run2a_5_7_batch_2000.nnet__PID_basic_2__M_marabou_with_ar__R_cegar__A_complete__RS_50__AS_100__DATETIME_2021-02-20_14:55:15 \
    experiments/dev_exp_results_archive/df_experiment__NN_ACASXU_run2a_5_7_batch_2000.nnet__PID_basic_2__M_marabou_with_ar__R_cegar__A_complete__RS_50__AS_100__DATETIME_2021-02-20_15:03:19 \
    experiments/dev_exp_results_archive/df_experiment__NN_ACASXU_run2a_5_7_batch_2000.nnet__PID_basic_2__M_marabou_with_ar__R_cegar__A_complete__RS_50__AS_100__DATETIME_2021-02-20_15:09:25 \
    experiments/dev_exp_results_archive/df_experiment__NN_ACASXU_run2a_5_7_batch_2000.nnet__PID_basic_2__M_marabou_with_ar__R_cegar__A_complete__RS_50__AS_100__DATETIME_2021-02-20_15:12:36 \
    experiments/dev_exp_results_archive/df_experiment__NN_ACASXU_run2a_5_7_batch_2000.nnet__PID_basic_2__M_marabou_with_ar__R_cegar__A_complete__RS_50__AS_100__DATETIME_2021-02-20_15:15:06 \
    experiments/dev_exp_results_archive/df_experiment__NN_ACASXU_run2a_5_7_batch_2000.nnet__PID_basic_2__M_marabou_with_ar__R_cegar__A_complete__RS_50__AS_100__DATETIME_2021-02-20_16:09:45 \
    experiments/dev_exp_results_archive/df_experiment__NN_ACASXU_run2a_5_7_batch_2000.nnet__PID_basic_2__M_marabou_with_ar__R_cegar__A_complete__RS_50__AS_100__DATETIME_2021-02-20_18:33:00 \
    experiments/dev_exp_results_archive/df_experiment__NN_ACASXU_run2a_5_7_batch_2000.nnet__PID_basic_2__M_marabou_with_ar__R_cegar__A_complete__RS_50__AS_100__DATETIME_2021-02-20_22:51:45 \
    experiments/dev_exp_results_archive/df_experiment__NN_ACASXU_run2a_5_7_batch_2000.nnet__PID_basic_2__M_marabou_with_ar__R_cegar__A_complete__RS_50__AS_100__DATETIME_2021-02-20_22:53:21 \
    experiments/dev_exp_results_archive/experiment__NN_ACASXU_run2a_1_1_batch_2000.nnet__PID_adversarial_0__M_marabou_with_ar__R_cegar__A_complete__RS_50__AS_100__DATETIME_2021-03-08_19:19:26 \
    experiments/dev_exp_results_archive/experiment__NN_ACASXU_run2a_1_1_batch_2000.nnet__PID_adversarial_0__M_marabou_with_ar__R_cegar__A_complete__RS_50__AS_100__DATETIME_2021-03-08_20:11:18 \
    experiments/dev_exp_results_archive/experiment__NN_ACASXU_run2a_1_1_batch_2000.nnet__PID_adversarial_0__M_marabou_with_ar__R_cegar__A_complete__RS_50__AS_100__DATETIME_2021-03-08_20:12:57 \
    experiments/dev_exp_results_archive/experiment__NN_ACASXU_run2a_1_1_batch_2000.nnet__PID_adversarial_0__M_marabou_with_ar__R_cegar__A_complete__RS_50__AS_100__DATETIME_2021-03-08_20:13:18 \
    experiments/dev_exp_results_archive/experiment__NN_ACASXU_run2a_1_1_batch_2000.nnet__PID_adversarial_0__M_marabou_with_ar__R_cegar__A_complete__RS_50__AS_100__DATETIME_2021-03-08_20:14:10 \
    experiments/dev_exp_results_archive/experiment__NN_ACASXU_run2a_1_1_batch_2000.nnet__PID_adversarial_0__M_marabou_with_ar__R_cegar__A_complete__RS_50__AS_100__DATETIME_2021-03-08_20:14:53 \
    experiments/dev_exp_results_archive/experiment__NN_ACASXU_run2a_1_1_batch_2000.nnet__PID_adversarial_0__M_marabou_with_ar__R_cegar__A_complete__RS_50__AS_100__DATETIME_2021-03-08_20:15:40 \
    experiments/dev_exp_results_archive/experiment__NN_ACASXU_run2a_1_1_batch_2000.nnet__PID_adversarial_0__M_marabou_with_ar__R_cegar__A_complete__RS_50__AS_100__DATETIME_2021-03-08_20:17:14 \
    experiments/dev_exp_results_archive/experiment__NN_ACASXU_run2a_1_1_batch_2000.nnet__PID_adversarial_0__M_marabou_with_ar__R_cegar__A_complete__RS_50__AS_100__DATETIME_2021-03-08_20:18:26 \
    experiments/dev_exp_results_archive/experiment__NN_ACASXU_run2a_1_1_batch_2000.nnet__PID_adversarial_0__M_marabou_with_ar__R_cegar__A_complete__RS_50__AS_100__DATETIME_2021-03-08_20:19:55 \
    experiments/dev_exp_results_archive/experiment__NN_ACASXU_run2a_1_1_batch_2000.nnet__PID_adversarial_0__M_marabou_with_ar__R_cegar__A_complete__RS_50__AS_100__DATETIME_2021-03-08_20:26:28 \
    experiments/dev_exp_results_archive/experiment__NN_ACASXU_run2a_1_2_batch_2000.nnet__PID_adversarial_0__M_marabou_with_ar__R_cegar__A_complete__RS_50__AS_100__DATETIME_2021-02-20_14:38:02 \
    experiments/dev_exp_results_archive/experiment__NN_ACASXU_run2a_1_2_batch_2000.nnet__PID_adversarial_0__M_marabou_with_ar__R_cegar__A_complete__RS_50__AS_100__DATETIME_2021-03-08_19:20:01 \
    experiments/dev_exp_results_archive/experiment__NN_ACASXU_run2a_1_2_batch_2000.nnet__PID_adversarial_0__M_marabou_with_ar__R_cegar__A_complete__RS_50__AS_100__DATETIME_2021-03-08_20:18:01 \
    experiments/dev_exp_results_archive/experiment__NN_ACASXU_run2a_1_2_batch_2000.nnet__PID_adversarial_0__M_marabou_with_ar__R_cegar__A_complete__RS_50__AS_100__DATETIME_2021-03-08_20:20:19 \
    experiments/dev_exp_results_archive/experiment__NN_ACASXU_run2a_1_2_batch_2000.nnet__PID_adversarial_0__M_marabou_with_ar__R_cegar__A_complete__RS_50__AS_100__DATETIME_2021-03-08_20:23:15 \
    experiments/dev_exp_results_archive/experiment__NN_ACASXU_run2a_1_2_batch_2000.nnet__PID_adversarial_0__M_marabou_with_ar__R_cegar__A_complete__RS_50__AS_100__DATETIME_2021-03-08_20:26:44 \
    experiments/dev_exp_results_archive/experiment__NN_ACASXU_run2a_1_2_batch_2000.nnet__PID_adversarial_0__M_marabou_with_ar__R_cegar__A_complete__RS_50__AS_100__DATETIME_2021-03-08_21:55:06 \
    experiments/dev_exp_results_archive/experiment__NN_ACASXU_run2a_1_2_batch_2000.nnet__PID_adversarial_0__M_marabou_with_ar__R_cegar__A_complete__RS_50__AS_100__DATETIME_2021-03-08_22:01:01 \
    experiments/dev_exp_results_archive/experiment__NN_ACASXU_run2a_1_2_batch_2000.nnet__PID_adversarial_0__M_marabou_with_ar__R_cegar__A_complete__RS_50__AS_100__DATETIME_2021-03-08_22:07:15 \
    experiments/dev_exp_results_archive/experiment__NN_ACASXU_run2a_1_2_batch_2000.nnet__PID_adversarial_0__M_marabou_with_ar__R_cegar__A_complete__RS_50__AS_100__DATETIME_2021-03-08_22:08:11 \
    experiments/dev_exp_results_archive/experiment__NN_ACASXU_run2a_1_2_batch_2000.nnet__PID_adversarial_0__M_marabou_with_ar__R_cegar__A_complete__RS_50__AS_100__DATETIME_2021-03-08_23:09:22 \
    experiments/dev_exp_results_archive/experiment__NN_ACASXU_run2a_1_2_batch_2000.nnet__PID_adversarial_0__M_marabou_with_ar__R_cegar__A_complete__RS_50__AS_100__DATETIME_2021-03-08_23:58:24 \
    experiments/dev_exp_results_archive/experiment__NN_ACASXU_run2a_1_2_batch_2000.nnet__PID_adversarial_0__M_marabou_with_ar__R_cegar__A_complete__RS_50__AS_100__DATETIME_2021-03-09_20:55:09 \
    experiments/dev_exp_results_archive/experiment__NN_ACASXU_run2a_1_3_batch_2000.nnet__PID_adversarial_0__M_marabou_with_ar__R_cegar__A_complete__RS_50__AS_100__DATETIME_2021-03-08_19:20:16 \
    experiments/dev_exp_results_archive/experiment__NN_ACASXU_run2a_1_3_batch_2000.nnet__PID_adversarial_0__M_marabou_with_ar__R_cegar__A_complete__RS_50__AS_100__DATETIME_2021-03-08_19:20:52 \
    experiments/dev_exp_results_archive/experiment__NN_ACASXU_run2a_1_3_batch_2000.nnet__PID_adversarial_0__M_marabou_with_ar__R_cegar__A_complete__RS_50__AS_100__DATETIME_2021-03-08_19:29:13 \
    experiments/dev_exp_results_archive/experiment__NN_ACASXU_run2a_1_3_batch_2000.nnet__PID_adversarial_0__M_marabou_with_ar__R_cegar__A_complete__RS_50__AS_100__DATETIME_2021-03-08_20:26:53 \
    experiments/dev_exp_results_archive/experiment__NN_ACASXU_run2a_1_4_batch_2000.nnet__PID_adversarial_0__M_marabou_with_ar__R_cegar__A_complete__RS_50__AS_100__DATETIME_2021-03-08_20:27:02 \
    experiments/dev_exp_results_archive/experiment__NN_ACASXU_run2a_1_5_batch_2000.nnet__PID_adversarial_0__M_marabou_with_ar__R_cegar__A_complete__RS_50__AS_100__DATETIME_2021-03-08_20:27:10 \
    experiments/dev_exp_results_archive/experiment__NN_ACASXU_run2a_1_6_batch_2000.nnet__PID_adversarial_0__M_marabou_with_ar__R_cegar__A_complete__RS_50__AS_100__DATETIME_2021-03-08_20:27:19 \
    experiments/dev_exp_results_archive/experiment__NN_ACASXU_run2a_1_8_batch_2000.nnet__PID_adversarial_0__M_marabou_with_ar__R_cegar__A_complete__RS_50__AS_100__DATETIME_2021-03-08_20:50:48 \
    experiments/dev_exp_results_archive/experiment__NN_ACASXU_run2a_1_9_batch_2000.nnet__PID_adversarial_0__M_marabou_with_ar__R_cegar__A_complete__RS_50__AS_100__DATETIME_2021-03-08_20:51:06 \
    experiments/dev_exp_results_archive/experiment__NN_ACASXU_run2a_2_1_batch_2000.nnet__PID_adversarial_0__M_marabou_with_ar__R_cegar__A_complete__RS_50__AS_100__DATETIME_2021-03-08_20:51:13 \
    experiments/dev_exp_results_archive/experiment__NN_ACASXU_run2a_2_2_batch_2000.nnet__PID_adversarial_0__M_marabou_with_ar__R_cegar__A_complete__RS_50__AS_100__DATETIME_2021-03-08_20:51:20 \
    experiments/dev_exp_results_archive/experiment__NN_ACASXU_run2a_2_3_batch_2000.nnet__PID_adversarial_0__M_marabou_with_ar__R_cegar__A_complete__RS_50__AS_100__DATETIME_2021-03-08_19:29:38 \
    experiments/dev_exp_results_archive/experiment__NN_ACASXU_run2a_2_3_batch_2000.nnet__PID_adversarial_0__M_marabou_with_ar__R_cegar__A_complete__RS_50__AS_100__DATETIME_2021-03-08_20:51:27 \
    experiments/dev_exp_results_archive/experiment__NN_ACASXU_run2a_2_5_batch_2000.nnet__PID_adversarial_0__M_marabou_with_ar__R_cegar__A_complete__RS_50__AS_100__DATETIME_2021-03-08_19:30:17 \
    experiments/dev_exp_results_archive/experiment__NN_ACASXU_run2a_2_5_batch_2000.nnet__PID_adversarial_0__M_marabou_with_ar__R_cegar__A_complete__RS_50__AS_100__DATETIME_2021-03-08_19:32:53 \
    experiments/dev_exp_results_archive/experiment__NN_ACASXU_run2a_2_5_batch_2000.nnet__PID_adversarial_0__M_marabou_with_ar__R_cegar__A_complete__RS_50__AS_100__DATETIME_2021-03-08_19:35:04 \
    experiments/dev_exp_results_archive/experiment__NN_ACASXU_run2a_2_5_batch_2000.nnet__PID_adversarial_0__M_marabou_with_ar__R_cegar__A_complete__RS_50__AS_100__DATETIME_2021-03-08_19:39:48 \
    experiments/dev_exp_results_archive/experiment__NN_ACASXU_run2a_2_5_batch_2000.nnet__PID_adversarial_0__M_marabou_with_ar__R_cegar__A_complete__RS_50__AS_100__DATETIME_2021-03-08_19:52:33 \
    experiments/dev_exp_results_archive/experiment__NN_ACASXU_run2a_2_5_batch_2000.nnet__PID_adversarial_0__M_marabou_with_ar__R_cegar__A_complete__RS_50__AS_100__DATETIME_2021-03-08_19:53:32 \
    experiments/dev_exp_results_archive/experiment__NN_ACASXU_run2a_2_8_batch_2000.nnet__PID_adversarial_0__M_marabou_with_ar__R_cegar__A_complete__RS_50__AS_100__DATETIME_2021-02-19_22:57:07 \
    experiments/dev_exp_results_archive/experiment__NN_ACASXU_run2a_2_8_batch_2000.nnet__PID_adversarial_0__M_marabou_with_ar__R_cegar__A_complete__RS_50__AS_100__DATETIME_2021-02-20_14:31:56 \
    experiments/dev_exp_results_archive/experiment__NN_ACASXU_run2a_2_8_batch_2000.nnet__PID_adversarial_0__M_marabou_with_ar__R_cegar__A_complete__RS_50__AS_100__DATETIME_2021-02-28_18:22:43 \
    experiments/dev_exp_results_archive/experiment__NN_ACASXU_run2a_2_8_batch_2000.nnet__PID_adversarial_0__M_marabou_with_ar__R_cegar__A_complete__RS_50__AS_100__DATETIME_2021-02-28_19:50:49 \
    experiments/dev_exp_results_archive/experiment__NN_ACASXU_run2a_2_8_batch_2000.nnet__PID_adversarial_0__M_marabou_with_ar__R_cegar__A_complete__RS_50__AS_100__DATETIME_2021-02-28_20:28:38 \
    experiments/dev_exp_results_archive/experiment__NN_ACASXU_run2a_2_8_batch_2000.nnet__PID_adversarial_0__M_marabou_with_ar__R_cegar__A_complete__RS_50__AS_100__DATETIME_2021-02-28_20:41:17 \
    experiments/dev_exp_results_archive/experiment__NN_ACASXU_run2a_2_8_batch_2000.nnet__PID_adversarial_0__M_marabou_with_ar__R_cegar__A_complete__RS_50__AS_100__DATETIME_2021-03-06_14:41:18 \
    experiments/dev_exp_results_archive/experiment__NN_ACASXU_run2a_2_8_batch_2000.nnet__PID_adversarial_0__M_marabou_with_ar__R_cegar__A_complete__RS_50__AS_100__DATETIME_2021-03-06_14:43:11 \
    experiments/dev_exp_results_archive/experiment__NN_ACASXU_run2a_2_8_batch_2000.nnet__PID_adversarial_0__M_marabou_with_ar__R_cegar__A_complete__RS_50__AS_100__DATETIME_2021-03-06_15:08:03 \
    experiments/dev_exp_results_archive/experiment__NN_ACASXU_run2a_2_8_batch_2000.nnet__PID_adversarial_0__M_marabou_with_ar__R_cegar__A_complete__RS_50__AS_100__DATETIME_2021-03-06_15:25:14 \
    experiments/dev_exp_results_archive/experiment__NN_ACASXU_run2a_2_8_batch_2000.nnet__PID_adversarial_0__M_marabou_with_ar__R_cegar__A_complete__RS_50__AS_100__DATETIME_2021-03-06_15:25:51 \
    experiments/dev_exp_results_archive/experiment__NN_ACASXU_run2a_2_8_batch_2000.nnet__PID_adversarial_0__M_marabou_with_ar__R_cegar__A_complete__RS_50__AS_100__DATETIME_2021-03-06_15:26:55 \
    experiments/dev_exp_results_archive/experiment__NN_ACASXU_run2a_2_8_batch_2000.nnet__PID_adversarial_0__M_marabou_with_ar__R_cegar__A_complete__RS_50__AS_100__DATETIME_2021-03-06_16:00:38 \
    experiments/dev_exp_results_archive/experiment__NN_ACASXU_run2a_2_8_batch_2000.nnet__PID_adversarial_0__M_marabou_with_ar__R_cegar__A_complete__RS_50__AS_100__DATETIME_2021-03-06_16:29:18 \
    experiments/dev_exp_results_archive/experiment__NN_ACASXU_run2a_2_8_batch_2000.nnet__PID_adversarial_0__M_marabou_with_ar__R_cegar__A_complete__RS_50__AS_100__DATETIME_2021-03-08_17:03:14 \
    experiments/dev_exp_results_archive/experiment__NN_ACASXU_run2a_2_8_batch_2000.nnet__PID_adversarial_0__M_marabou_with_ar__R_cegar__A_complete__RS_50__AS_100__DATETIME_2021-03-08_17:05:08 \
    experiments/dev_exp_results_archive/experiment__NN_ACASXU_run2a_2_8_batch_2000.nnet__PID_adversarial_0__M_marabou_with_ar__R_cegar__A_complete__RS_50__AS_100__DATETIME_2021-03-08_17:07:42 \
    experiments/dev_exp_results_archive/experiment__NN_ACASXU_run2a_2_8_batch_2000.nnet__PID_adversarial_0__M_marabou_with_ar__R_cegar__A_complete__RS_50__AS_100__DATETIME_2021-03-08_17:17:59 \
    experiments/dev_exp_results_archive/experiment__NN_ACASXU_run2a_2_8_batch_2000.nnet__PID_adversarial_0__M_marabou_with_ar__R_cegar__A_complete__RS_50__AS_100__DATETIME_2021-03-08_17:19:50 \
    experiments/dev_exp_results_archive/experiment__NN_ACASXU_run2a_2_8_batch_2000.nnet__PID_adversarial_0__M_marabou_with_ar__R_cegar__A_complete__RS_50__AS_100__DATETIME_2021-03-08_18:54:30 \
    experiments/dev_exp_results_archive/experiment__NN_ACASXU_run2a_2_8_batch_2000.nnet__PID_adversarial_0__M_marabou_with_ar__R_cegar__A_complete__RS_50__AS_100__DATETIME_2021-03-08_18:56:20 \
    experiments/dev_exp_results_archive/experiment__NN_ACASXU_run2a_2_8_batch_2000.nnet__PID_adversarial_0__M_marabou_with_ar__R_cegar__A_complete__RS_50__AS_100__DATETIME_2021-03-08_18:57:27 \
    experiments/dev_exp_results_archive/experiment__NN_ACASXU_run2a_2_8_batch_2000.nnet__PID_adversarial_0__M_marabou_with_ar__R_cegar__A_complete__RS_50__AS_100__DATETIME_2021-03-08_19:05:16 \
    experiments/dev_exp_results_archive/experiment__NN_ACASXU_run2a_2_8_batch_2000.nnet__PID_adversarial_0__M_marabou_with_ar__R_cegar__A_complete__RS_50__AS_100__DATETIME_2021-03-08_19:12:52 \
    experiments/dev_exp_results_archive/experiment__NN_ACASXU_run2a_2_8_batch_2000.nnet__PID_adversarial_0__M_marabou_with_ar__R_cegar__A_complete__RS_50__AS_100__DATETIME_2021-03-08_19:16:30 \
    experiments/dev_exp_results_archive/experiment__NN_ACASXU_run2a_2_8_batch_2000.nnet__PID_adversarial_0__M_marabou_with_ar__R_cegar__A_complete__RS_50__AS_100__DATETIME_2021-03-08_19:18:32 \
    experiments/dev_exp_results_archive/experiment__NN_ACASXU_run2a_2_8_batch_2000.nnet__PID_adversarial_0__M_marabou_with_ar__R_cegar__A_complete__RS_50__AS_100__DATETIME_2021-03-08_20:09:08 \
    experiments/dev_exp_results_archive/experiment__NN_ACASXU_run2a_5_7_batch_2000.nnet__PID_basic_2__M_marabou__R_cegar__A_complete__RS_50__AS_100__DATETIME_2021-02-20_15:29:03 \
    experiments/dev_exp_results_archive/experiment__NN_ACASXU_run2a_5_7_batch_2000.nnet__PID_basic_2__M_marabou_with_ar__R_cegar__A_complete__RS_50__AS_100__DATETIME_2021-02-20_14:55:15 \
    experiments/dev_exp_results_archive/experiment__NN_ACASXU_run2a_5_7_batch_2000.nnet__PID_basic_2__M_marabou_with_ar__R_cegar__A_complete__RS_50__AS_100__DATETIME_2021-02-20_15:03:19 \
    experiments/dev_exp_results_archive/experiment__NN_ACASXU_run2a_5_7_batch_2000.nnet__PID_basic_2__M_marabou_with_ar__R_cegar__A_complete__RS_50__AS_100__DATETIME_2021-02-20_15:09:25 \
    experiments/dev_exp_results_archive/experiment__NN_ACASXU_run2a_5_7_batch_2000.nnet__PID_basic_2__M_marabou_with_ar__R_cegar__A_complete__RS_50__AS_100__DATETIME_2021-02-20_15:12:36 \
    experiments/dev_exp_results_archive/experiment__NN_ACASXU_run2a_5_7_batch_2000.nnet__PID_basic_2__M_marabou_with_ar__R_cegar__A_complete__RS_50__AS_100__DATETIME_2021-02-20_15:15:06 \
    experiments/dev_exp_results_archive/experiment__NN_ACASXU_run2a_5_7_batch_2000.nnet__PID_basic_2__M_marabou_with_ar__R_cegar__A_complete__RS_50__AS_100__DATETIME_2021-02-20_16:09:45 \
    experiments/dev_exp_results_archive/experiment__NN_ACASXU_run2a_5_7_batch_2000.nnet__PID_basic_2__M_marabou_with_ar__R_cegar__A_complete__RS_50__AS_100__DATETIME_2021-02-20_18:33:00 \
    experiments/dev_exp_results_archive/experiment__NN_ACASXU_run2a_5_7_batch_2000.nnet__PID_basic_2__M_marabou_with_ar__R_cegar__A_complete__RS_50__AS_100__DATETIME_2021-02-20_22:51:45 \
    experiments/dev_exp_results_archive/experiment__NN_ACASXU_run2a_5_7_batch_2000.nnet__PID_basic_2__M_marabou_with_ar__R_cegar__A_complete__RS_50__AS_100__DATETIME_2021-02-20_22:53:21 \
    experiments/prepare/__init__.py \
    experiments/prepare/prepare_experiments.sh \
    experiments/prepare/prepare_experiments_cegarabou.sh \
    experiments/prepare/prepare_experiments_marabou.sh \
    experiments/prepare/prepare_sbatch_files.py \
    experiments/properties_to_verify/__init__.py \
    experiments/properties_to_verify/find_properties_to_verify.py \
    experiments/properties_to_verify/properties.txt \
    experiments/run/__init__.py \
    experiments/run/one_experiment.py \
    experiments/run/one_experiment_cegarabou.py \
    experiments/run/one_experiment_marabou.py \
    experiments/run/one_experiment_orig.py \
    experiments/run/run_experiments.sh \
    experiments/run/run_experiments_marabou.sh \
    experiments/technical_details.txt \
    experiments/visualize/__init__.py \
    experiments/visualize/plot_graph_best_cegarabou_vs_marabou_before_pp_wrt_all_properties.py \
    experiments/visualize/visualize_experiments_results_df.py

RESOURCES += \
    file.qrc \
    icon.qrc
INCLUDEPATH += -I /usr/include/python3.8
LIBS += -lpython3.8
