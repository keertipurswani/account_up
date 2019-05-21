from django.shortcuts import render

# Create your views here.

from django.http import HttpResponse
from django.http import JsonResponse
import ast
from . import my_model
from django.db import connections
import os
import traceback


def home(request):
    return HttpResponse('Hello, World! I am at home')


def index(request):
    # print("hello")
    return HttpResponse('Hello, I am at Index!')


def check_conn(request):
    # return HttpResponse('Hello, I am at Index!')

    try:
        connection = connections['ramyadb_2']
        cursor = connection.cursor()
        return HttpResponse('Connection successful!')
    except Exception as e:
        return HttpResponse('Connection error!')


def create_user(request):
    """

    :param request:
    :return:
    """
    try:
        status = 1

        request_body_dict = ast.literal_eval(request.body.decode('utf-8'))

        company = dict()
        company['username'] = request_body_dict.get('username', '')
        company['password'] = request_body_dict.get('password', '')

        if not company['username'] or not company['password']:
            raise Exception("Invalid data")

        data = my_model.add_new_user(company)

        result = {"Status": 1, "User_id": data, "Data": "User added successfully"}
        return JsonResponse(result, json_dumps_params={'indent': 2})

    except Exception as e:
        status = 0
        data = str(e)
        a = {"Status": status, "Data": data}
        return JsonResponse(a, json_dumps_params={'indent': 2})


def login_user(request):
    """
    :prupose:
    :param request:
    :return:
    """

    try:
        status = 1

        company = dict()
        company['username'] = request.META.get('HTTP_USERNAME', '')
        company['password'] = request.META.get('HTTP_PASSWORD', '')

        if not company['username'] or not company['password']:
            raise Exception("Invalid data")

        data = my_model.validate_login_user(company)

        result = {"Status": 1, "User_id": data, "Data": "User logged in successfully"}
        return JsonResponse(result, json_dumps_params={'indent': 2})


    except Exception as e:
        status = 0
        data = str(e)
        a = {"Status": status, "Data": data}
        return JsonResponse(a, json_dumps_params={'indent': 2})


def create_company(request):
    """

    :param request:
    :return:
    """

    try:
        status = 1

        request_body_dict = ast.literal_eval(request.body.decode('utf-8'))

        company = dict()
        company['userId'] = request_body_dict.get('userId', 1)
        company['name'] = request_body_dict.get('name', '')
        company['addr'] = request_body_dict.get('addr', '')
        company['gstin'] = request_body_dict.get('gstin', '')
        company['mobNum'] = request_body_dict.get('mobNum', '')
        company['emailId'] = request_body_dict.get('emailId', '')

        if not company['userId'] or not company['name'] or not company['gstin']:
            raise Exception("Invalid data")

        data = my_model.create_a_company(company)

        result = {"Status": 1, "Company_id": data, "Data": "Company added successfully"}
        return JsonResponse(result, json_dumps_params={'indent': 2})

    except Exception as e:
        status = 0
        data = str(e)
        a = {"Status": status, "Data": data}
        return JsonResponse(a, json_dumps_params={'indent': 2})


def add_party(request):
    """

    :param request:
    :return:
    """

    try:
        status = 1
        request_body_dict = ast.literal_eval(request.body.decode('utf-8'))

        company = dict()
        company['companyId'] = request_body_dict.get('companyId', 1)
        company['party_type'] = request_body_dict.get('party_type', 1)
        company['name'] = request_body_dict.get('name', '')
        company['addr'] = request_body_dict.get('addr', '')
        company['gstin'] = request_body_dict.get('gstin', '')
        company['mobNum'] = request_body_dict.get('mobNum', '')
        company['emailId'] = request_body_dict.get('emailId', '')
        company['remarks'] = request_body_dict.get('remarks', '')

        if not company['companyId'] or not company['party_type'] or not company['name'] or not company['gstin']:
            raise Exception("Invalid data")

        data = my_model.add_company_party(company)

        result = {"Status": 1, "party_id": data, "Data": "Company Party added successfully"}
        return JsonResponse(result, json_dumps_params={'indent': 2})

    except Exception as e:
        status = 0
        data = str(e)
        a = {"Status": status, "Data": data}
        return JsonResponse(a, json_dumps_params={'indent': 2})


def show_all_parties_for_a_company(request):
    """
    :purpose:
    :param request:
    :return:
    """

    try:
        status = 1
        # request_body_dict = ast.literal_eval(request.body.decode('utf-8'))

        company = dict()
        company['companyId'] = request.META.get('HTTP_COMPANYID', '')
        company['party_type'] = request.META.get('HTTP_PARTYTYPE', '')

        if not company['companyId'] or not company['party_type']:
            raise Exception("Invalid data")

        data = my_model.show_all_parties_for_a_company(company)

        result = {"Status": 1, "Data": data}
        return JsonResponse(result, json_dumps_params={'indent': 2})


    except Exception as e:
        status = 0
        data = str(e)
        a = {"Status": status, "Data": data}
        return JsonResponse(a, json_dumps_params={'indent': 2})


def add_main_stock_item(request):
    """

    :param request:
    :return:
    """

    try:
        status = 1
        request_body_dict = ast.literal_eval(request.body.decode('utf-8'))

        company = dict()
        company['companyId'] = request_body_dict.get('companyId', 1)
        company['item_type'] = request_body_dict.get('item_type', '')
        company['main_group_id'] = request_body_dict.get('main_group_id', 0)
        company['sub_group_id'] = request_body_dict.get('sub_group_id', 0)
        company['item_name'] = request_body_dict.get('item_name', '')
        company['base_price'] = request_body_dict.get('base_price', 0)
        company['quantity'] = str(request_body_dict.get('quantity', ''))
        company['tax_percent'] = str(request_body_dict.get('tax_percent', ''))
        company['unit_of_measure'] = request_body_dict.get('unit_of_measure', '')

        if len(company['quantity']) < 1:
            company['quantity'] = 0
        if len(company['tax_percent']) < 1:
            company['tax_percent'] = 0

        data = my_model.add_stock_item(company)

        result = {"Status": 1, "item_id": data, "Data": "Company Stock added successfully"}
        return JsonResponse(result, json_dumps_params={'indent': 2})

    except Exception as e:
        status = 0
        data = str(e)
        a = {"Status": status, "Data": data}
        return JsonResponse(a, json_dumps_params={'indent': 2})


def add_stock_main_group_item(request):
    """

    :param request:
    :return:
    """

    try:
        status = 1
        request_body_dict = ast.literal_eval(request.body.decode('utf-8'))

        company = dict()
        company['companyId'] = request_body_dict.get('companyId', 1)
        company['main_group_name'] = request_body_dict.get('main_group_name', '')

        if not company['companyId'] or not company['main_group_name']:
            raise Exception("Invalid data")

        data = my_model.add_stock_main_group_item(company)

        result = {"Status": 1, "main_group_id": data, "Data": "Main group added successfully"}
        return JsonResponse(result, json_dumps_params={'indent': 2})

    except Exception as e:
        status = 0
        data = str(e)
        a = {"Status": status, "Data": data}
        return JsonResponse(a, json_dumps_params={'indent': 2})


def add_stock_sub_group_item(request):
    """

    :param request:
    :return:
    """

    # try:
    status = 1
    request_body_dict = ast.literal_eval(request.body.decode('utf-8'))

    company = dict()
    company['companyId'] = request_body_dict.get('companyId', 1)
    company['main_group_id'] = request_body_dict.get('main_group_id', 0)
    company['sub_group_name'] = request_body_dict.get('sub_group_name', '')

    if not company['companyId'] or not company['main_group_id'] or not company['sub_group_name']:
        raise Exception("Invalid data")

    data = my_model.add_stock_sub_group_item(company)

    result = {"Status": 1, "sub_group_id": data, "Data": "Sub group added successfully"}
    return JsonResponse(result, json_dumps_params={'indent': 2})

    # except Exception as e:
    #     status = 0
    #     data = str(e)
    #     a = {"Status": status, "Data": data}
    #     return JsonResponse(a, json_dumps_params={'indent': 2})


def get_item_group_details(request):
    """
    :prupose:
    :param request:
    :return:
    """

    try:
        status = 1
        # request_body_dict = ast.literal_eval(request.body.decode('utf-8'))

        company = dict()
        company['companyId'] = request.META.get('HTTP_COMPANYID', '')

        if not company['companyId']:
            raise Exception("Invalid data")

        data = my_model.get_item_group_details(company)

        result = {"Status": 1, "Data": data}
        return JsonResponse(result, json_dumps_params={'indent': 2})


    except Exception as e:
        status = 0
        data = str(e)
        a = {"Status": status, "Data": data}
        return JsonResponse(a, json_dumps_params={'indent': 2})


def get_item_details(request):
    """
    :prupose:
    :param request:
    :return:
    """

    try:
        status = 1
        # request_body_dict = ast.literal_eval(request.body.decode('utf-8'))

        company = dict()
        company['companyId'] = request.META.get('HTTP_COMPANYID', '')
        company['item_type'] = request.META.get('HTTP_ITEMTYPE', '')

        if not company['companyId'] or not company['item_type']:
            raise Exception("Invalid data")

        data = my_model.get_item_details(company)

        result = {"Status": 1, "Data": data}
        return JsonResponse(result, json_dumps_params={'indent': 2})


    except Exception as e:
        status = 0
        data = str(e)
        a = {"Status": status, "Data": data}
        return JsonResponse(a, json_dumps_params={'indent': 2})


def add_employee(request):
    """

        :param request:
        :return:
        """

    try:
        status = 1
        request_body_dict = ast.literal_eval(request.body.decode('utf-8'))

        company = dict()
        company['cmp_id'] = request_body_dict.get('cmp_id', 1)
        company['name'] = request_body_dict.get('name', '')
        company['addr'] = request_body_dict.get('addr', '')
        company['desig'] = request_body_dict.get('desig', '')
        company['mob_num'] = request_body_dict.get('mob_num', '')
        company['email'] = request_body_dict.get('email', '')
        company['age'] = request_body_dict.get('age', '')
        company['gender'] = request_body_dict.get('gender', '')

        if not company['cmp_id'] or not company['name']:
            raise Exception("Invalid data")

        if not company['age']:
            company['age'] = None
        else:
            company['age'] = int(company['age'])

        if not company['gender']:
            company['gender'] = None
        else:
            company['gender'] = int(company['gender'])

        data = my_model.add_employee(company)

        result = {"Status": 1, "emp_id": data, "Data": "Company Employee added successfully"}
        return JsonResponse(result, json_dumps_params={'indent': 2})

    except Exception as e:
        status = 0
        data = str(e)
        a = {"Status": status, "Data": data}
        return JsonResponse(a, json_dumps_params={'indent': 2})


def get_employee(request):
    """
    :purpose:
    :param request:
    :return:
    """

    try:
        status = 1
        # request_body_dict = ast.literal_eval(request.body.decode('utf-8'))

        company = dict()
        company['cmp_id'] = request.META.get('HTTP_CMPID', '')
        # company['emp_id'] = request.META.get('HTTP_EMPID', '')

        if not company['cmp_id']:
            raise Exception("Invalid data")

        data = my_model.get_employee(company)

        result = {"Status": 1, "Data": data}
        return JsonResponse(result, json_dumps_params={'indent': 2})


    except Exception as e:
        status = 0
        data = str(e)
        a = {"Status": status, "Data": data}
        return JsonResponse(a, json_dumps_params={'indent': 2})


def update_employee(request):
    """

        :param request:
        :return:
    """

    try:
        status = 1
        request_body_dict = ast.literal_eval(request.body.decode('utf-8'))

        company = dict()
        company['cmp_id'] = request_body_dict.get('cmp_id', 1)
        company['emp_id'] = request_body_dict.get('emp_id', 1)
        company['name'] = request_body_dict.get('name', '')
        company['addr'] = request_body_dict.get('addr', '')
        company['desig'] = request_body_dict.get('desig', '')
        company['mob_num'] = request_body_dict.get('mob_num', '')
        company['email'] = request_body_dict.get('email', '')
        company['age'] = request_body_dict.get('age', '')
        company['gender'] = request_body_dict.get('gender', '')

        if not company['cmp_id'] or not company['name']:
            raise Exception("Invalid data")

        if not company['age']:
            company['age'] = None
        else:
            company['age'] = int(company['age'])

        if not company['gender']:
            company['gender'] = None
        else:
            company['gender'] = int(company['gender'])

        data = my_model.update_employee(company)

        result = {"Status": 1, "emp_id": data, "Data": "Employee Details updated successfully"}
        return JsonResponse(result, json_dumps_params={'indent': 2})

    except Exception as e:
        status = 0
        data = str(e)
        a = {"Status": status, "Data": data}
        return JsonResponse(a, json_dumps_params={'indent': 2})


def add_goal(request):
    """

        :param request:
        :return:
        """

    try:
        status = 1
        request_body_dict = ast.literal_eval(request.body.decode('utf-8'))

        company = dict()
        company['cmp_id'] = request_body_dict.get('cmp_id', 1)
        company['title'] = request_body_dict.get('title', '')
        company['descr'] = request_body_dict.get('descr', '')
        company['start_date'] = request_body_dict.get('start_date', '')
        company['end_date'] = request_body_dict.get('end_date', '')
        company['track'] = request_body_dict.get('track', '')

        if not company['cmp_id'] or not company['title']:
            raise Exception("Invalid data")

        if not company['track']:
            company['track'] = None
        else:
            company['track'] = int(company['track'])

        data = my_model.add_goal(company)

        result = {"Status": 1, "goal_id": data, "Data": "Company Goal added successfully"}
        return JsonResponse(result, json_dumps_params={'indent': 2})

    except Exception as e:
        status = 0
        data = str(e)
        a = {"Status": status, "Data": data}
        return JsonResponse(a, json_dumps_params={'indent': 2})


def get_goal(request):
    """
    :purpose:
    :param request:
    :return:
    """

    try:
        status = 1
        # request_body_dict = ast.literal_eval(request.body.decode('utf-8'))

        company = dict()
        company['cmp_id'] = request.META.get('HTTP_CMPID', '')
        # company['goal_id'] = request.META.get('HTTP_GOALID', '')

        if not company['cmp_id']:  # or not company['goal_id']:
            raise Exception("Invalid data")

        data = my_model.get_goal(company)

        result = {"Status": 1, "Data": data}
        return JsonResponse(result, json_dumps_params={'indent': 2})


    except Exception as e:
        status = 0
        data = str(e)
        a = {"Status": status, "Data": data}
        return JsonResponse(a, json_dumps_params={'indent': 2})


def update_goal(request):
    """

        :param request:
        :return:
    """

    try:
        status = 1
        request_body_dict = ast.literal_eval(request.body.decode('utf-8'))

        company = dict()
        company['cmp_id'] = request_body_dict.get('cmp_id', 1)
        company['goal_id'] = request_body_dict.get('goal_id', 1)
        company['title'] = request_body_dict.get('title', '')
        company['descr'] = request_body_dict.get('descr', '')
        company['start_date'] = request_body_dict.get('start_date', '')
        company['end_date'] = request_body_dict.get('end_date', '')
        company['track'] = request_body_dict.get('track', '')
        company['status'] = request_body_dict.get('status', '')
        company['remarks'] = request_body_dict.get('remarks', '')

        if not company['cmp_id'] or not company['goal_id'] or not company['title']:
            raise Exception("Invalid data")

        if not company['track']:
            company['track'] = None
        else:
            company['track'] = int(company['track'])

        if not company['status']:
            company['status'] = None
            company['remarks'] = None
        else:
            company['status'] = int(company['status'])

        data = my_model.update_goal(company)

        result = {"Status": 1, "goal_id": data, "Data": "Employee Details updated successfully"}
        return JsonResponse(result, json_dumps_params={'indent': 2})

    except Exception as e:
        status = 0
        data = str(e)
        a = {"Status": status, "Data": data}
        return JsonResponse(a, json_dumps_params={'indent': 2})


def update_track(request):
    """

        :param request:
        :return:
    """

    try:
        status = 1
        request_body_dict = ast.literal_eval(request.body.decode('utf-8'))

        company = dict()
        company['cmp_id'] = request_body_dict.get('cmp_id', 1)
        company['goal_id'] = request_body_dict.get('goal_id', 1)
        company['track'] = request_body_dict.get('track', '')

        if not company['cmp_id'] or not company['goal_id'] or not company['track']:
            raise Exception("Invalid data")

        data = my_model.update_track(company)

        result = {"Status": 1, "goal_id": data, "Data": "Employee Details updated successfully"}
        return JsonResponse(result, json_dumps_params={'indent': 2})

    except Exception as e:
        status = 0
        data = str(e)
        a = {"Status": status, "Data": data}
        return JsonResponse(a, json_dumps_params={'indent': 2})


def update_goal_status(request):
    """

        :param request:
        :return:
    """

    try:
        status = 1
        request_body_dict = ast.literal_eval(request.body.decode('utf-8'))

        company = dict()
        company['cmp_id'] = request_body_dict.get('cmp_id', 1)
        company['goal_id'] = request_body_dict.get('goal_id', 1)
        company['track'] = request_body_dict.get('track', '')
        company['status'] = request_body_dict.get('status', '')
        company['remarks'] = request_body_dict.get('remarks', '')

        if not company['cmp_id'] or not company['goal_id'] or not company['track'] or not company['status']:
            raise Exception("Invalid data")

        if not company['track']:
            company['track'] = None
        else:
            company['track'] = int(company['track'])

        if not company['status']:
            company['status'] = None
            company['remarks'] = None
        else:
            company['status'] = int(company['status'])

        data = my_model.update_goal_status(company)

        result = {"Status": 1, "goal_id": data, "Data": "Employee Details updated successfully"}
        return JsonResponse(result, json_dumps_params={'indent': 2})

    except Exception as e:
        status = 0
        data = str(e)
        a = {"Status": status, "Data": data}
        return JsonResponse(a, json_dumps_params={'indent': 2})


def add_transaction(request):
    """

    :param request:
    :return:
    """

    try:
        status = 1
        request_body_dict = ast.literal_eval(request.body.decode('utf-8'))
        # print("request_body_dict : ", request_body_dict)

        company = dict()
        company['companyId'] = request_body_dict.get('companyId', 1)
        company['transaction_date'] = request_body_dict.get('transaction_date', '')
        company['transaction_ref_id'] = request_body_dict.get('transaction_ref_id', '')
        company['transaction_type'] = request_body_dict.get('transaction_type', 0)
        company['transaction_group_type'] = request_body_dict.get('transaction_group_type', 0)
        company['transaction_party_id'] = request_body_dict.get('transaction_party_id', 0)
        company['transaction_invoice_number'] = request_body_dict.get('transaction_invoice_number', '')
        company['transaction_total_price'] = request_body_dict.get('transaction_total_price', 0)
        company['transaction_remarks'] = request_body_dict.get('transaction_remarks', '')
        company['transaction_pay_now'] = request_body_dict.get('pay_now', '')

        company['item_details'] = request_body_dict.get('item_details', '')
        company['payment_details'] = request_body_dict.get('payment_details', '')

        # print(company['payment_details'])
        if not company['companyId']:
            raise Exception("Invalid data")

        data = my_model.add_transaction(company)

        result = {"Status": 1, "Data": "Transaction added successfully"}
        return JsonResponse(result, json_dumps_params={'indent': 2})

    except Exception as e:
        status = 0
        data = str(e)
        a = {"Status": status, "Data": data}
        return JsonResponse(a, json_dumps_params={'indent': 2})


def get_transaction(request):
    """
    :prupose:
    :param request:
    :return:
    """

    try:
        status = 1
        # request_body_dict = ast.literal_eval(request.body.decode('utf-8'))

        company = dict()
        company['companyId'] = request.META.get('HTTP_COMPANYID', '')

        if not company['companyId']:
            raise Exception("Invalid data")

        data = my_model.get_transaction(company)

        result = {"Status": 1, "Data": data}
        return JsonResponse(result, json_dumps_params={'indent': 2})


    except Exception as e:
        status = 0
        data = str(e)
        a = {"Status": status, "Data": data}
        return JsonResponse(a, json_dumps_params={'indent': 2})


