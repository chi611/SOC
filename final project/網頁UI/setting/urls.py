"""trackServer URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/3.0/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.conf.urls import include
from django.contrib import admin
from django.urls import path, re_path
from pingpong.views import index
from pingpong.requests import getCOM, connect, close, getData

urlpatterns = [
    path('admin/', admin.site.urls),
    path('', index),
    path(r"api/getCOM", getCOM),
    path(r"api/connect", connect),
    path(r"api/close", close),
    path(r"api/getData", getData),
    # path('selectNode', selectNode),
    # path('selectModel', selectModel),
    # path('modelLayerSetting', modelLayerSetting),
    # path('setting', setting),
    # path('accountManager', accountManager),
    # path('motionJPEG', mjpeg),
    # verificationService
    # path(r"", include("verificationService.urls")),
    # login
    # path(r"api/login", account.login),
    # path(r"api/checkAuth/<str:tokenData>", account.checkAuth),
    # # accountManager
    # path(r"api/accountAction", account.accountAction),
    # path(r"api/getServerMode", road.getServerMode),
    # # selectNode
    # path(r"api/getRoad", road.getRoad),
    # path(r"api/updateRoadInfo", road.updateRoadInfo),
    # path(r"api/roadGroup", road.manageRoadGroup),
    # path(r"api/deleteRoad", road.deleteRoad),
    # # 事件相關
    # path(r"api/getAccidentDateByNode/<str:node>", road.getAccidentDateByNode),
    # path(r"api/getAccidentByDate/<str:node>/<str:date>", road.getAccidentByDate),
    # # moveTrainingSet 
    # path(r"api/getFolder/<str:node>", road.getFolder),
    # path(r"api/getImageList/<str:node>/<str:folder>/<str:page>", road.getImageList),
    # path(r"api/moveImage/<str:node>", road.moveImage),
    # path(r"api/addFolder/<str:node>", road.addFolder),
    # path(r"api/deleteFolder/<str:node>", road.deleteFolder),
    # path(r"api/renameFolder/<str:node>", road.renameFolder),
    # path(r"api/uploadImage/<str:node>", road.uploadImage),
    # # selectModel
    # path(r"api/getModel/<str:node>", road.getModel),
    # path(r"api/score/<str:node>", road.score),
    # path(r"api/isSaveResult/<str:node>", road.isSaveResult),
    # # modelLayerSetting
    # path(r"api/getTree/<str:node>", road.getTree),
    # path(r"api/sendTreeData/<str:node>", road.sendTreeData),
    # # setting
    # path(r"api/setting/<str:node>", road.setting),
    # # surceillance
    # path(r"api/getVideoList/<str:node>/<str:key>/<str:queryDatetime>", road.getVideoList),
    # path(r"api/queryTrafficLog/<str:node>", road.queryTrafficLog),
    # path(r"api/streamVideo/<str:node>/<str:video>/<str:action>", road.streamVideo),
    # path(r"api/checkVideoExist/<str:node>/<str:video>", road.checkVideoExist),
    # path(r"api/getProgress/<str:node>/<str:video>", road.getProgress),
    # path(r"api/multiVideoConvertHandle/<str:node>", road.multiVideoConvertHandle),
    # # ntp
    # path(r"api/ntp/<str:nodeTime>", ntpServer.getTime),
    # re_path(r"api/downloadFile/(.*)$", road.downloadFile)
]
