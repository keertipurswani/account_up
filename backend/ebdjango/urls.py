"""ebdjango URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/2.1/topics/http/urls/
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
from django.contrib import admin
from django.urls import path
from myapp import views

urlpatterns = [
    path('admin/', admin.site.urls),
    path('', views.index, name='index'),
    path('home', views.home, name='home'),
    path('check_conn', views.check_conn, name='check_conn'),
    # path('show_all_user', views.create_user, name='show_all_user'),

    path('create_user', views.create_user, name='create_user'),
    path('login', views.login_user, name='login'),

    path('create_company', views.create_company, name='create_company'),

    path('add_party', views.add_party, name='add_party'),
    path('get_party_details', views.show_all_parties_for_a_company, name='get_party_details'),

    path('add_stock_item', views.add_main_stock_item, name='add_stock_item'),
    path('add_stock_main_group', views.add_stock_main_group_item, name='add_stock_item'),
    path('add_stock_sub_group', views.add_stock_sub_group_item, name='add_stock_item'),

    path('get_item_group_details', views.get_item_group_details, name='get_item_group_details'),
    path('get_item_details', views.get_item_details, name='get_item_details'),

    path('add_transaction', views.add_transaction, name='add_transaction'),
    path('get_transaction', views.get_transaction, name='add_transaction'),

    path('add_emp', views.add_employee, name='add_emp'),
    path('get_emp', views.get_employee, name='get_emp'),
    path('update_emp', views.update_employee, name='update_emp'),

    path('add_goal', views.add_goal, name='add_goal'),
    path('get_goal', views.get_goal, name='get_goal'),
    path('update_goal', views.update_goal, name='update_goal'),
    path('update_track', views.update_track, name='update_track'),
    path('update_gstatus', views.update_goal_status, name='update_gstatus'),

]
