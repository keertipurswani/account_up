from django.db import connections
from passlib.hash import sha256_crypt

SALES = 1
PURCHASE = 2
PAYMENT = 3
RECEIPT = 4

def add_new_user(kwargs):
    '''

    :return:
    '''

    connection = connections['ramyadb_2']
    cursor = connection.cursor()

    query = '''
        INSERT INTO TBL_ACCOUNTUP_USERS (
            FLD_USER_LOGIN_ID,
            FLD_USER_PASSWORD,
            FLD_ADDED_DATETIME
        ) 
        VALUES
            (
            %s, 
            %s, 
            NOW() ) ;
    '''

    cursor.execute(query, (kwargs['username'], sha256_crypt.encrypt(kwargs['password'])))
    connection.commit()

    user_id = cursor.lastrowid  # connection.insert_id()
    return user_id


def validate_login_user(kwargs):
    """

    :return:
    """

    connection = connections['ramyadb_2']
    cursor = connection.cursor()

    query = '''
            SELECT 
                TAU.FLD_USER_ID
            FROM
                TBL_ACCOUNTUP_USERS AS TAU 
            WHERE TAU.FLD_USER_LOGIN_ID = %s 
            # AND TAU.FLD_USER_PASSWORD =   ;
    '''

    # print(query %(kwargs['username'], sha256_crypt.encrypt(kwargs['password']) ))
    # cursor.execute(query, (kwargs['username'], sha256_crypt.encrypt(kwargs['password']) ) )

    cursor.execute(query, (kwargs['username'],))

    if cursor.rowcount > 0:
        res = cursor.fetchall()
        return res[0][0]

    return 0


def create_a_company(kwargs):
    """

    :param kwargs:
    :return:
    """

    connection = connections['ramyadb_2']
    cursor = connection.cursor()

    query = '''
        INSERT INTO TBL_ACCOUNTUP_COMPANY (
            FLD_USER_ID,
            FLD_COMPANY_NAME,
            FLD_COMPANY_ADDR,
            FLD_COMPANY_GSTIN,
            FLD_COMPANY_EMAIL,
            FLD_COMPANY_PHONE,
            FLD_STATUS,
            FLD_ADDED_DATETIME
        ) 
        VALUES
            (
                %s,
                %s,
                %s,
                %s,
                %s,
                %s,
                1,
                NOW()
            ) ;
    '''

    cursor.execute(query, (
    int(kwargs['userId']), kwargs['name'], kwargs['addr'], kwargs['gstin'], kwargs['emailId'], kwargs['mobNum']))
    connection.commit()

    company_id = cursor.lastrowid  # connection.insert_id()
    return company_id


def show_all_company_for_a_user():
    """

    :return:
    """

    connection = connections['ramyadb_2']
    cursor = connection.cursor()

    query = '''
    SELECT * FROM TBL_ACCOUNTUP_USERS;
    '''

    cursor.execute(query)

    if cursor.rowcount > 0:
        columns = [x[0] for x in cursor.description]
        temp_dict = []

        for row in cursor:
            row = dict(zip(columns, row))

            temp_dict.append({'user_id': row['FLD_USER_ID'], 'user_login_id': row['FLD_USER_LOGIN_ID']})

    return temp_dict


def add_company_party(kwargs):
    """

    :param kwargs:
    :return:
    """

    connection = connections['ramyadb_2']
    cursor = connection.cursor()

    query = '''
        INSERT INTO TBL_OTHER_PARTY_COMPANY (
            FLD_COMPANY_ID,
            FLD_PARTY_TYPE,
            FLD_PARTY_NAME,

            FLD_PARTY_ADDR,
            FLD_PARTY_GSTIN,
            FLD_PARTY_EMAIL,

            FLD_PARTY_PHONE,
            FLD_REMARKS,

            FLD_STATUS,
            FLD_ADDED_DATETIME
        ) 
        VALUES
            (
                %s,
                %s,
                %s,

                %s,
                %s,
                %s,

                %s,
                %s,
                1,
                NOW()
            ) ;
    '''

    cursor.execute(query, (int(kwargs['companyId']), int(kwargs['party_type']), kwargs['name'], kwargs['addr'],
                           kwargs['gstin'], kwargs['emailId'], kwargs['mobNum'], kwargs['remarks']))
    connection.commit()
    party_id = cursor.lastrowid

    return party_id


def show_all_parties_for_a_company(kwargs):
    """

    :return:
    """

    connection = connections['ramyadb_2']
    cursor = connection.cursor()

    query = '''
        SELECT 
            TOPC.FLD_PARTY_INST_ID AS PARTY_ID,
            TOPC.FLD_PARTY_NAME AS PARTY_NAME,
            TOPC.FLD_PARTY_ADDR AS PARTY_ADDR,
            TOPC.FLD_PARTY_GSTIN AS PARTY_GSTIN,
            TOPC.FLD_PARTY_PHONE AS PARTY_PHONE,
            TOPC.FLD_PARTY_EMAIL AS PARTY_EMAIL,
            TOPC.`FLD_REMARKS` AS PARTY_REMARKS
        FROM
            TBL_OTHER_PARTY_COMPANY AS TOPC 
        WHERE TOPC.FLD_COMPANY_ID = %s
        AND TOPC.FLD_PARTY_TYPE = %s
        AND TOPC.FLD_STATUS = 1 ; 
    '''

    cursor.execute(query, (int(kwargs['companyId']), int(kwargs['party_type'])))

    temp_dict = []
    if cursor.rowcount > 0:
        columns = [x[0] for x in cursor.description]
        temp_dict = []

        for row in cursor:
            row = dict(zip(columns, row))

            temp_dict.append(row)

    return temp_dict


def add_stock_item(kwargs):
    """

    :param kwargs:
    :return:
    """

    connection = connections['ramyadb_2']
    cursor = connection.cursor()

    query = '''
        INSERT INTO TBL_ACCOUNTUP_ITEMS (
            FLD_COMPANY_ID,
            FLD_ITEM_TYPE,
            FLD_ITEM_MAIN_GROUP_ID,
            FLD_ITEM_SUB_GROUP_ID,

            FLD_ITEM_NAME,
            FLD_BASE_PRICE,
            FLD_QUANTITY,
            FLD_TAX_PERCENT,

            FLD_UNIT_OF_MEASURE,
            FLD_STATUS,
            FLD_ADDED_DATETIME
        ) 
        VALUES
            (
                %s,
                %s,
                %s,
                %s,

                %s,
                %s,
                %s,
                %s,

                %s,
                1,
                NOW()
            ) ;
    '''

    cursor.execute(query, (
    int(kwargs['companyId']), int(kwargs['item_type']), kwargs['main_group_id'], kwargs['sub_group_id'],
    kwargs['item_name'],
    float(kwargs['base_price']), int(kwargs['quantity']), float(kwargs['tax_percent']), kwargs['unit_of_measure'],))
    connection.commit()

    item_id = cursor.lastrowid
    return item_id


def add_stock_main_group_item(kwargs):
    """

    :param kwargs:
    :return:
    """

    connection = connections['ramyadb_2']
    cursor = connection.cursor()

    query = '''
        INSERT INTO TBL_ACCOUNTUP_ITEMS_MAIN_GROUP (
            FLD_COMPANY_ID,
            FLD_ITEM_MAIN_GROUP_NAME,
            FLD_STATUS,
            FLD_ADDED_DATETIME
        ) 
        VALUES
            (
                %s,
                %s,
                1,
                NOW()
            ) ;
    '''

    cursor.execute(query, (int(kwargs['companyId']), kwargs['main_group_name']))
    connection.commit()

    main_group_id = cursor.lastrowid
    return main_group_id


def add_stock_sub_group_item(kwargs):
    """

    :param kwargs:
    :return:
    """

    connection = connections['ramyadb_2']
    cursor = connection.cursor()

    query = '''
            INSERT INTO TBL_ACCOUNTUP_ITEMS_SUB_GROUP (
                FLD_COMPANY_ID,
                FLD_MAIN_GROUP_ITEM_ID,
                FLD_ITEM_SUB_GROUP_NAME,
                FLD_STATUS,
                FLD_ADDED_DATETIME
            ) 
            VALUES
                (
                    %s,
                    %s,
                    %s,
                    1,
                    NOW()
                ) ;
        '''

    cursor.execute(query, (int(kwargs['companyId']), int(kwargs['main_group_id']), kwargs['sub_group_name']))
    connection.commit()

    sub_group_id = cursor.lastrowid
    return sub_group_id


def get_item_group_details(kwargs):
    """

    :return:
    """

    connection = connections['ramyadb_2']
    cursor = connection.cursor()

    query = '''
        SELECT 
            TAIMG.FLD_MAIN_GROUP_ITEM_ID,
            TAIMG.FLD_ITEM_MAIN_GROUP_NAME,
            TAISG.FLD_SUB_GROUP_ITEM_ID,
            TAISG.FLD_ITEM_SUB_GROUP_NAME 
        FROM
            TBL_ACCOUNTUP_ITEMS_MAIN_GROUP AS TAIMG 
            INNER JOIN TBL_ACCOUNTUP_ITEMS_SUB_GROUP AS TAISG 
                ON TAIMG.FLD_MAIN_GROUP_ITEM_ID = TAISG.FLD_MAIN_GROUP_ITEM_ID 
                AND TAIMG.FLD_STATUS = 1 
                AND TAISG.FLD_STATUS = 1 
                AND TAIMG.FLD_COMPANY_ID = %s
        ORDER BY TAIMG.FLD_ITEM_MAIN_GROUP_NAME,
            TAISG.FLD_ITEM_SUB_GROUP_NAME ;
    '''

    cursor.execute(query, (int(kwargs['companyId']),))

    item_group_data = []
    if cursor.rowcount > 0:
        old_main_item_name = ''
        old_main_item_id = 0
        columns = [x[0] for x in cursor.description]
        temp_data_list = list()

        for row in cursor.fetchall():
            row = dict(zip(columns, row))

            if old_main_item_id == row['FLD_MAIN_GROUP_ITEM_ID']:
                temp_data_list.append(
                    {'sub_group_id': row['FLD_SUB_GROUP_ITEM_ID'],
                     'sub_group_name': row['FLD_ITEM_SUB_GROUP_NAME']})

            else:
                if old_main_item_id != 0:
                    item_group_data.append({'main_group_id': old_main_item_id,
                                            'main_group_name': old_main_item_name,
                                            'item_group_list': temp_data_list})

                old_main_item_id = row['FLD_MAIN_GROUP_ITEM_ID']
                old_main_item_name = row['FLD_ITEM_MAIN_GROUP_NAME']
                temp_data_list = list()
                temp_data_list.append(
                    {'sub_group_id': row['FLD_SUB_GROUP_ITEM_ID'],
                     'sub_group_name': row['FLD_ITEM_SUB_GROUP_NAME']})

        item_group_data.append({'main_group_id': old_main_item_id,
                                'main_group_name': old_main_item_name,
                                'item_group_list': temp_data_list})

    return item_group_data


def get_item_details(kwargs):
    """

    :return:
    """

    connection = connections['ramyadb_2']
    cursor = connection.cursor()

    query = '''
        SELECT 
            TAIMG.FLD_MAIN_GROUP_ITEM_ID,
            TAIMG.FLD_ITEM_MAIN_GROUP_NAME,
            TAISG.FLD_SUB_GROUP_ITEM_ID,
            TAISG.FLD_ITEM_SUB_GROUP_NAME,
            TAI.FLD_ITEM_INST_ID,
            TAI.FLD_ITEM_NAME,
            TAI.FLD_ITEM_TYPE,
            TAI.FLD_BASE_PRICE,
            TAI.FLD_QUANTITY,
            TAI.FLD_TAX_PERCENT,
            TAI.FLD_UNIT_OF_MEASURE 
        FROM
            TBL_ACCOUNTUP_ITEMS_MAIN_GROUP AS TAIMG 

            INNER JOIN TBL_ACCOUNTUP_ITEMS_SUB_GROUP AS TAISG 
                ON TAIMG.FLD_MAIN_GROUP_ITEM_ID = TAISG.FLD_MAIN_GROUP_ITEM_ID 
                AND TAIMG.FLD_STATUS = 1 
                AND TAISG.FLD_STATUS = 1 
                AND TAIMG.FLD_COMPANY_ID = %s

            INNER JOIN TBL_ACCOUNTUP_ITEMS AS TAI 
                ON TAIMG.FLD_MAIN_GROUP_ITEM_ID = TAI.FLD_ITEM_MAIN_GROUP_ID 
                AND TAISG.FLD_SUB_GROUP_ITEM_ID = TAI.FLD_ITEM_SUB_GROUP_ID 
                AND TAIMG.FLD_COMPANY_ID = TAI.FLD_COMPANY_ID 
                AND TAI.FLD_STATUS = 1 
                AND TAI.FLD_ITEM_TYPE = %s

        ORDER BY TAIMG.FLD_ITEM_MAIN_GROUP_NAME,
            TAISG.FLD_ITEM_SUB_GROUP_NAME,
            TAI.FLD_ITEM_NAME ;
    '''

    cursor.execute(query, (int(kwargs['companyId']), int(kwargs['item_type'])))

    item_data = []
    if cursor.rowcount > 0:
        old_main_item_name = ''
        old_main_item_id = 0

        old_sup_item_name = ''
        old_sup_item_id = 0

        columns = [x[0] for x in cursor.description]
        temp_item_data_list = list()
        temp_group_data_list = list()

        for row in cursor.fetchall():
            row = dict(zip(columns, row))

            if old_main_item_id == row['FLD_MAIN_GROUP_ITEM_ID']:

                if old_sup_item_id == row['FLD_SUB_GROUP_ITEM_ID']:
                    temp_item_data_list.append(
                        {
                            'item_id': row['FLD_ITEM_INST_ID'],
                            'item_name': row['FLD_ITEM_NAME'],
                            'item_type': row['FLD_ITEM_TYPE'],
                            'item_price': row['FLD_BASE_PRICE'],
                            'item_quantity': row['FLD_QUANTITY'],
                            'item_tax_percent': row['FLD_TAX_PERCENT'],
                            'item_unit_of_measure': row['FLD_UNIT_OF_MEASURE']
                        }
                    )
                else:
                    if old_sup_item_id != 0:
                        temp_group_data_list.append({
                            'sub_group_id': old_sup_item_id,
                            'sub_group_name': old_sup_item_name,
                            'item_details': temp_item_data_list
                        })

                    old_sup_item_id = row['FLD_SUB_GROUP_ITEM_ID']
                    old_sup_item_name = row['FLD_ITEM_SUB_GROUP_NAME']
                    temp_item_data_list = []
                    temp_item_data_list.append(
                        {
                            'item_id': row['FLD_ITEM_INST_ID'],
                            'item_name': row['FLD_ITEM_NAME'],
                            'item_type': row['FLD_ITEM_TYPE'],
                            'item_price': row['FLD_BASE_PRICE'],
                            'item_quantity': row['FLD_QUANTITY'],
                            'item_tax_percent': row['FLD_TAX_PERCENT'],
                            'item_unit_of_measure': row['FLD_UNIT_OF_MEASURE']
                        }
                    )

            else:
                if old_main_item_id != 0:
                    item_data.append({
                        'main_group_id': old_main_item_id,
                        'main_group_name': old_main_item_name,
                        'item_group_list': temp_group_data_list
                    })

                old_main_item_id = row['FLD_MAIN_GROUP_ITEM_ID']
                old_main_item_name = row['FLD_ITEM_MAIN_GROUP_NAME']
                old_sup_item_id = row['FLD_SUB_GROUP_ITEM_ID']
                old_sup_item_name = row['FLD_ITEM_SUB_GROUP_NAME']
                temp_item_data_list = list()
                temp_group_data_list = list()
                temp_item_data_list.append(
                    {
                        'item_id': row['FLD_ITEM_INST_ID'],
                        'item_name': row['FLD_ITEM_NAME'],
                        'item_type': row['FLD_ITEM_TYPE'],
                        'item_price': row['FLD_BASE_PRICE'],
                        'item_quantity': row['FLD_QUANTITY'],
                        'item_tax_percent': row['FLD_TAX_PERCENT'],
                        'item_unit_of_measure': row['FLD_UNIT_OF_MEASURE']
                    }
                )

        temp_group_data_list.append({
            'sub_group_id': old_sup_item_id,
            'sub_group_name': old_sup_item_name,
            'item_details': temp_item_data_list
        })

        item_data.append({
            'main_group_id': old_main_item_id,
            'main_group_name': old_main_item_name,
            'item_group_list': temp_group_data_list
        })

    return item_data


def add_employee(kwargs):
    """

    :param kwargs:
    :return:
    """

    connection = connections['ramyadb_2']
    cursor = connection.cursor()

    query = '''
        INSERT INTO TBL_ACCOUNTUP_EMPLOYEE_DETAILS (
            FLD_COMPANY_ID,
            FLD_EMPLOYEE_NAME,
            FLD_EMPLOYEE_DESIGNATION,
            FLD_EMPLOYEE_ADDR,
            FLD_EMPLOYEE_EMAIL,
            FLD_EMPLOYEE_PHONE,
            FLD_EMPLOYEE_AGE,
            FLD_EMPLOYEE_GENDER,
            FLD_STATUS,
            FLD_ADDED_DATETIME
        ) 
        VALUES
            (%s, %s, %s, %s,   %s, %s, %s, %s, 1, NOW() ) ;
    '''

    cursor.execute(query, (int(kwargs['cmp_id']),
                           kwargs['name'],
                           kwargs['addr'],
                           kwargs['desig'],
                           kwargs['email'],
                           kwargs['mob_num'],
                           kwargs['age'],
                           kwargs['gender']))
    connection.commit()
    emp_id = cursor.lastrowid

    return emp_id


def get_employee(kwargs):
    """

        :return:
        """

    connection = connections['ramyadb_2']
    cursor = connection.cursor()

    query = '''
            SELECT 
                TAED.FLD_EMPLOYEE_INST_ID as empid,
                TAED.FLD_EMPLOYEE_NAME AS ename,
                TAED.FLD_EMPLOYEE_DESIGNATION AS desig,
                TAED.FLD_EMPLOYEE_ADDR AS addr,
                TAED.FLD_EMPLOYEE_EMAIL AS email,
                TAED.FLD_EMPLOYEE_PHONE AS phone,
                TAED.FLD_EMPLOYEE_AGE AS age ,
                TAED.FLD_EMPLOYEE_GENDER AS gender
            FROM
                TBL_ACCOUNTUP_EMPLOYEE_DETAILS AS TAED 
            WHERE TAED.FLD_COMPANY_ID = %s 
                AND TAED.FLD_STATUS = 1 ;
        '''

    cursor.execute(query, (int(kwargs['cmp_id']),))

    temp_dict = []
    if cursor.rowcount > 0:
        columns = [x[0] for x in cursor.description]
        temp_dict = []

        for row in cursor:
            row = dict(zip(columns, row))

            temp_dict.append(row)

    return temp_dict


def update_employee(kwargs):
    """

    :param kwargs:
    :return:
    """

    connection = connections['ramyadb_2']
    cursor = connection.cursor()

    query = '''
        UPDATE 
            TBL_ACCOUNTUP_EMPLOYEE_DETAILS AS TAED 
        SET
            TAED.`FLD_EMPLOYEE_NAME` = %s,
            TAED.FLD_EMPLOYEE_DESIGNATION = %s,
            TAED.FLD_EMPLOYEE_ADDR = %s,
            TAED.FLD_EMPLOYEE_EMAIL = %s,
            TAED.FLD_EMPLOYEE_PHONE = %s,
            TAED.FLD_EMPLOYEE_AGE = %s,
            TAED.FLD_EMPLOYEE_GENDER = %s 
        WHERE TAED.FLD_COMPANY_ID = %s 
            AND TAED.FLD_EMPLOYEE_INST_ID = %s ;
    '''

    cursor.execute(query, (kwargs['name'],
                           kwargs['addr'],
                           kwargs['desig'],
                           kwargs['email'],
                           kwargs['mob_num'],
                           kwargs['age'],
                           kwargs['gender'],
                           int(kwargs['cmp_id']),
                           int(kwargs['emp_id'])))
    connection.commit()
    emp_id = cursor.lastrowid

    # throw an error if no rows are updated
    return emp_id


def add_goal(kwargs):
    """

    :param kwargs:
    :return:
    """

    connection = connections['ramyadb_2']
    cursor = connection.cursor()

    query = '''
        INSERT INTO TBL_ACCOUNTUP_GOAL_TRACKING (
            FLD_COMPANY_ID,
            FLD_GOAL_TITLE,
            FLD_GOAL_DESC,

            FLD_GOAL_START_DATE,
            FLD_GOAL_END_DATE,
            FLD_GOAL_TRACKING_STATUS,

            FLD_STATUS,
            FLD_ADDED_DATETIME
        ) 
        VALUES
            (%s, %s, %s,   %s, %s, %s, 1, NOW() ) ;
    '''

    cursor.execute(query, (int(kwargs['cmp_id']),
                           kwargs['title'],
                           kwargs['descr'],
                           kwargs['start_date'],
                           kwargs['end_date'],
                           kwargs['track']))
    connection.commit()
    goal_id = cursor.lastrowid

    return goal_id


def get_goal(kwargs):
    """

        :return:
        """

    connection = connections['ramyadb_2']
    cursor = connection.cursor()

    query = '''
            SELECT 
                TAGT.FLD_GOAL_INST_ID AS goal_id,
                TAGT.FLD_GOAL_TITLE AS title,
                TAGT.FLD_GOAL_DESC AS descr,
                TAGT.FLD_GOAL_START_DATE AS startdate,
                TAGT.FLD_GOAL_END_DATE AS enddate,
                TAGT.FLD_GOAL_TRACKING_STATUS AS track 
            FROM
                TBL_ACCOUNTUP_GOAL_TRACKING AS TAGT 
            WHERE TAGT.FLD_COMPANY_ID = %s 

                AND TAGT.FLD_STATUS = 1 ;
        '''

    cursor.execute(query, (int(kwargs['cmp_id']),))

    temp_dict = []
    if cursor.rowcount > 0:
        columns = [x[0] for x in cursor.description]
        temp_dict = []

        for row in cursor:
            row = dict(zip(columns, row))

            temp_dict.append(row)

    return temp_dict


def update_goal(kwargs):
    """

    :param kwargs:
    :return:
    """

    connection = connections['ramyadb_2']
    cursor = connection.cursor()

    query = '''
        UPDATE 
            TBL_ACCOUNTUP_GOAL_TRACKING AS TAGT 
        SET
            TAGT.FLD_GOAL_TITLE = %s,
            TAGT.FLD_GOAL_DESC = %s,
            TAGT.FLD_GOAL_START_DATE = %s,
            TAGT.FLD_GOAL_END_DATE = %s,
            TAGT.FLD_GOAL_TRACKING_STATUS = %s,
            TAGT.`FLD_GOAL_STATUS` = %s,
            TAGT.`FLD_GOAL_STATUS_REMARKS` = %s
        WHERE TAGT.FLD_COMPANY_ID = %s
            AND TAGT.FLD_GOAL_INST_ID = %s ;
    '''

    cursor.execute(query, (kwargs['title'],
                           kwargs['descr'],
                           kwargs['start_date'],
                           kwargs['end_date'],
                           kwargs['track'],
                           kwargs['status'],
                           kwargs['remarks'],
                           int(kwargs['cmp_id']),
                           int(kwargs['goal_id'])))
    connection.commit()

    # throw an error if no rows are updated
    return 1


def update_track(kwargs):
    """

    :param kwargs:
    :return:
    """

    connection = connections['ramyadb_2']
    cursor = connection.cursor()

    query = '''
        UPDATE 
            TBL_ACCOUNTUP_GOAL_TRACKING AS TAGT 
        SET
            TAGT.FLD_GOAL_TRACKING_STATUS = %s
        WHERE TAGT.FLD_COMPANY_ID = %s
            AND TAGT.FLD_GOAL_INST_ID = %s ;
    '''

    cursor.execute(query, (int(kwargs['track']),
                           int(kwargs['cmp_id']),
                           int(kwargs['goal_id'])))
    connection.commit()

    # throw an error if no rows are updated
    return 1


def update_goal_status(kwargs):
    """

    :param kwargs:
    :return:
    """

    connection = connections['ramyadb_2']
    cursor = connection.cursor()

    query = '''
        UPDATE 
            TBL_ACCOUNTUP_GOAL_TRACKING AS TAGT 
        SET
            TAGT.FLD_GOAL_TRACKING_STATUS = %s,
            TAGT.`FLD_GOAL_STATUS` = %s,
            TAGT.`FLD_GOAL_STATUS_REMARKS` = %s
        WHERE TAGT.FLD_COMPANY_ID = %s
            AND TAGT.FLD_GOAL_INST_ID = %s ;
    '''

    cursor.execute(query, (int(kwargs['track']),
                           int(kwargs['status']),
                           kwargs['remarks'],
                           int(kwargs['cmp_id']),
                           int(kwargs['goal_id'])))
    connection.commit()

    # throw an error if no rows are updated
    return 1


def add_transaction(kwargs):
    """

    :return:
    """

    connection = connections['ramyadb_2']
    cursor = connection.cursor()

    query = '''
        INSERT INTO TBL_ACCOUNTUP_TRANSACTIONS (
            FLD_COMPANY_ID,
            FLD_TRANSACTION_DATE,
            FLD_TRANSACTION_REF_ID,

            FLD_TRANSACTION_TYPE,
            FLD_TRANSACTION_GROUP_TYPE,
            FLD_PARTY_ID,

            FLD_INVOICE_NUMBER,
            FLD_TRANSACTION_PAY_NOW_FLAG,
            FLD_TOTAL_PRICE,

            FLD_STATUS,
            FLD_ADDED_DATETIME,
            FLD_REMARKS
        ) 
        VALUES
            (%s, %s, %s,  %s, %s, %s,  %s, %s, %s, 1, NOW(), %s) ;
    '''

    cursor.execute(query, (int(kwargs['companyId']),
                           kwargs['transaction_date'],
                           int(kwargs['transaction_ref_id']),

                           int(kwargs['transaction_type']),
                           int(kwargs['transaction_group_type']),
                           int(kwargs['transaction_party_id']),

                           kwargs['transaction_invoice_number'],
                           int(kwargs['transaction_pay_now']),
                           float(kwargs['transaction_total_price']),

                           kwargs['transaction_remarks']
                           ))

    connection.commit()

    transaction_id = cursor.lastrowid

    # print("transaction_id : ", transaction_id)

    for each_item in kwargs['item_details']:
        query = '''
                INSERT INTO TBL_ACCOUNTUP_TRANSACTION_ITEMS (
                    FLD_COMPANY_ID,
                    FLD_TRANSACTION_ID,

                    FLD_ITEM_ID,
                    FLD_BASE_PRICE,
                    FLD_QUANTITY,
                    FLD_TAX_PERCENT,
                    FLD_TOTAL,

                    FLD_ADDED_DATETIME
                ) 
                VALUES
                    ( %s, %s, %s,  %s, %s, %s, %s,  NOW()) ;
            '''

        each_item['item_id'] = int(each_item['item_id']) if each_item['item_id'] else None
        each_item['item_quantity'] = int(each_item['item_quantity']) if each_item['item_quantity'] else None
        each_item['item_base_price'] = float(each_item['item_base_price']) if each_item['item_base_price'] else None
        each_item['item_tax_percent'] = float(each_item['item_tax_percent']) if each_item['item_tax_percent'] else None
        each_item['item_total_price'] = float(each_item['item_total_price']) if each_item['item_total_price'] else None

        cursor.execute(query, (int(kwargs['companyId']),
                               transaction_id,
                               each_item['item_id'],
                               each_item['item_base_price'],
                               each_item['item_quantity'],
                               each_item['item_tax_percent'],
                               each_item['item_total_price']
                               ))

        connection.commit()

        # update item quantity in item master table
        if each_item['item_quantity']:
            item_query = ''
            if kwargs['transaction_type'] == PURCHASE:
                item_query = '''
                    UPDATE 
                        TBL_ACCOUNTUP_ITEMS AS TAI 
                    SET
                        TAI.`FLD_QUANTITY` = TAI.`FLD_QUANTITY` + %s 
                    WHERE TAI.`FLD_ITEM_INST_ID` = %s ;
                '''
            elif kwargs['transaction_type'] == SALES:
                item_query = '''
                    UPDATE 
                        TBL_ACCOUNTUP_ITEMS AS TAI 
                    SET
                        TAI.`FLD_QUANTITY` = TAI.`FLD_QUANTITY` - %s 
                    WHERE TAI.`FLD_ITEM_INST_ID` = %s ;
                '''

            cursor.execute(item_query, (each_item['item_quantity'], each_item['item_id'])  )
            connection.commit()


    if kwargs['transaction_pay_now'] == 1:
        for each_payment in kwargs['payment_details']:
            query = '''
                INSERT INTO TBL_ACCOUNTUP_TRANSACTION_PAYMENTS (
                    FLD_COMPANY_ID,
                    FLD_TRANSACTION_ID,

                    FLD_TOTAL_PRICE,
                    FLD_PAYMENT_METHOD,
                    FLD_PAYMENT_AMOUNT,
                    FLD_PAYMENT_DATE,
                    FLD_PAYMENT_ID,
                    FLD_REMARKS,

                    FLD_ADDED_DATETIME
                ) 
                VALUES
                    ( %s, %s, %s,   %s, %s, %s,   %s, %s, NOW()) ;
                '''

            each_payment['payment_method'] = int(each_payment['payment_method']) if each_payment['payment_method'] else None
            each_payment['payment_amount'] = float(each_payment['payment_amount']) if each_payment['payment_amount'] else None
            each_payment['payment_id'] = float(each_payment['payment_id']) if each_payment['payment_id'] else None

            cursor.execute(query, (int(kwargs['companyId']),
                                   transaction_id,
                                   kwargs['transaction_total_price'],

                                   each_payment['payment_method'],
                                   each_payment['payment_amount'],
                                   each_payment['payment_date'],
                                   each_payment['payment_id'],
                                   each_payment['payment_remarks']
                                   ))

            connection.commit()

def get_transaction(kwargs):
    """

    :return:
    """

    connection = connections['ramyadb_2']
    cursor = connection.cursor()

    query = '''
        SELECT 
            TAT.FLD_TRANSACTION_INST_ID AS TRANS_ID,
            TAT.FLD_TRANSACTION_DATE AS TRANS_DATE,
            TOPC.FLD_PARTY_NAME AS TRANS_PARTY_NAME,
            TAT.FLD_TOTAL_PRICE AS TRANS_PRICE
        FROM
            TBL_ACCOUNTUP_TRANSACTIONS AS TAT 
            INNER JOIN TBL_OTHER_PARTY_COMPANY AS TOPC 
                ON TOPC.FLD_COMPANY_ID = TAT.FLD_COMPANY_ID
                AND TOPC.FLD_PARTY_INST_ID = TAT.FLD_PARTY_ID
        WHERE TAT.FLD_COMPANY_ID = %s ;
    '''

    cursor.execute(query, (int(kwargs['companyId']),))

    temp_dict = []
    if cursor.rowcount > 0:
        columns = [x[0] for x in cursor.description]
        temp_dict = []

        for row in cursor:
            row = dict(zip(columns, row))

            temp_dict.append(row)

    return temp_dict





