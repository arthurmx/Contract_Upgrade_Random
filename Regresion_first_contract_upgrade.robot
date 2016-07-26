*** Settings ***
Documentation               This is a simple test with Robot FrameWork
Library                     Selenium2Library
Library                     OperatingSystem
Library                     DatabaseLibrary
Library                     Collections
Library                     robot.libraries.DateTime
Library                     String
Library                     RandomDevice.py
Library                     RandomTariff.py
Library                     RandomAddon.py
Library                     Screenshot
Library                     robot.libraries.DateTime


*** Variables ***
${URL} =  https://172.28.172.157/contractupgradestore/shop/login
${BROWSER} =  chrome
${AREA_CODE}  xpath=//*[@id='MobileNumber_AreaCode']
${MOBILE_FIELD}  id=MobileNumber_Main
${CONTINUE_BUTTON}  xpath=.//*[@id='inner-wrap']/div[3]/div/div[2]/a
${PAGE_LOAD}  xpath=//*[@id='container']/div[2]/form/div/h3
${GO_TO_STORE}  xpath=//*[@id='inner-wrap']/div[3]/div/a[1]
${DATE_OF_BIRTH_DAY}  xpath=.//*[@id='s2id_DateOfBirth_Day']/a/span[1]
${DATE_OF_BIRTH_FIELD_DAY}  xpath=.//*[@id='select2-drop']/div/input
${DATE_OF_BIRTH_MM}  xpath=.//*[@id='s2id_DateOfBirth_Month']/a/span[1]
${DATE_OF_BIRTH_FIELD_MM}  xpath=.//*[@id='select2-drop']/div/input
${DATE_OF_BIRTH_FIELD_Y}  xpath=.//*[@id='DateOfBirth_Year']



${PIN_FIELD}  xpath=//*[@id='PIN']
${DATE_OF_BIRTH_FIELD}  xpath=//*[@id='DateOfBirth_Date']
${NAME}  H3GI
${USERNAME1}  b4nuser
${PASSWORD1}  telex12
${SERVERNAME}  STH3GISQL
${PORT}  1433
${ALCATEL_TEST}  xpath=//*[@id='container']/div[3]/div[5]/div/div[1]
${CHANGE_DEVICE}  id=btnChangeDevice
${DEVICE_DETAILS_CONTINUE}  xpath=//*[@id='container']/div/div[4]/div/div/div[4]/div[5]/a

${MANUFACTURER_DROPDOWN}  xpath=//*[@id='show-hide-manf']/div[2]
${CONTINUE_BUTTON1}  css=.button.continueBtn.button-100
${BACK_BUTTON}  css=.button.left.back.backBtn


#Price Plan page

${TC_CHECKBOX}  xpath = //*[@id='divPricePlanChanges']/div/label
${CONTINUE_BUTTON_P}  xpath = //*[@id='inner-wrap']/div[3]/div/div[2]/a[2]

${CONTINUE_ADDON}  css=.button.right.continueBtn.submit
${CONTINUE_INSURANCE}  css=.button.right.continueBtn.submit
${INSURANCE_BACK}  css=.button.left.back.backBtn
#${INSURANCE_BACK}  xpath=.//*[@id='container']/div/form/div/div[2]/a[1]

#insurance window

${INSURANCE_Y}  xpath=.//*[@id='divInsurance']/div[3]/a[2]
${INSURANCE_N}  xpath=.//*[@id='container']/div/form/div/div[2]/a[2]




${PD_TC}  xpath=.//*[@id='checkoutContract']/div[3]/div[1]/form/div[11]/div[3]/label/span

${EXTRA_SIM}  xpath=.//*[@id='s2id_ExtraSim']/a/span[1]
${EXTRA_SIM_FIELD}  xpath=.//*[@id='select2-drop']/div/input




${SUBMIT_BUTTON}  css=.button.right.continueBtn.submit.continueBtnPayment
*** Keywords ***


*** Keywords ***
Open Browser to Eligibility
       Open Browser  ${URL}  ${BROWSER}
       Maximize Browser Window

Connect to DB
    Connect to database  pymssql  ${NAME}  ${USERNAME1}  ${PASSWORD1}  ${SERVERNAME}  ${PORT}


Get Upgrade ID
    Connect to DB
    ${TEST1}=  Query  use h3gi select top 1 UpgradeId from h3giUpgrade inner join h3giPricePlanPackage on h3giPricePlanPackage.peopleSoftID = h3giUpgrade.PeoplesoftID where customerPrepay = 2 and DateUsed is null and isBroadband = 0 and Band in ('B', 'C') and mobileNumberAreaCode = 083 and eligibilityStatus = 1 and catalogueVersionID in (select catVer.catalogueVersionID from h3giCatalogueVersion catVer where activeCatalog = 'Y') order by DateAdded desc


    [Return]  ${TEST1}

Get Number

    [Arguments]  ${UPGRADE_ID1}
    ${TEST2}=  Query  use h3gi Select mobileNumberMain FROM h3giUpgrade where UpgradeID = '${UPGRADE_ID1[0][0]}'
    [Return]  ${TEST2}

Get Date of Birth
    [Arguments]  ${UPGRADE_ID1}
    ${TEST3}=  Query  use h3gi Select dateOfBirth FROM h3giUpgrade where UpgradeID = '${UPGRADE_ID1[0][0]}'
    [Return]  ${TEST3}


Get Password
    [Arguments]  ${UPGRADE_ID1}
    ${TEST4}=  Query  use h3gi SELECT top 1 Password from h3gicustomerUpgradePassword where upgradeid = '${UPGRADE_ID1[0][0]}' order by dateStamp desc
    [Return]  ${TEST4}

#use h3gi Select dateOfBirth FROM h3giUpgrade where UpgradeID = '${UPGRADE_ID1[0][0]}'





Mobile Form
    ${UPGRADE_ID1} =  Get Upgrade ID
    ${MOBILE_NR}=  Get Number  ${UPGRADE_ID1}
    ${DATE_OF_BIRTH}  Get Date of Birth  ${UPGRADE_ID1}
    ${DATE1}  convert to string  ${DATE_OF_BIRTH[0][0]}


    ${DATE_DAY} =  convert date  ${DATE_OF_BIRTH[0][0]}  result_format=%d
    #${DATE_DAY_F}=  Strip String  ${DATE_DAY}  left  0


    ${DATE_MONTH} =  convert date  ${DATE_OF_BIRTH[0][0]}  result_format=%m
   # ${DATE_MONTH_F}=  Strip String  ${DATE_MONTH}  left  0

    ${DATE_YEAR} =  convert date  ${DATE_OF_BIRTH[0][0]}  result_format=%Y


    press key  ${AREA_CODE}  083
    press key  ${MOBILE_FIELD}  ${MOBILE_NR[0][0]}
    log to console  ${MOBILE_NR[0][0]}



    click element  ${date_of_birth_day}
    press key  ${date_of_birth_field_day}  ${DATE_DAY}
    press key  ${MOBILE_FIELD}  \\13


    click element  ${date_of_birth_mm}
    press key  ${date_of_birth_field_mm}  ${DATE_MONTH}
    press key  ${MOBILE_FIELD}  \\13

    press key  ${date_of_birth_field_y}  ${DATE_YEAR}

    click element  ${CONTINUE_BUTTON}


      wait until page contains element  ${GO_TO_STORE}  10
    ${PIN}  Get Password  ${UPGRADE_ID1}
    press key  ${PIN_FIELD}  ${PIN[0][0]}
    press key  ${PIN_FIELD}  \\13

#Random Device Selection

Random Device

    ${Count}=  Get matching xpath count    //*[@id='container']/div[3]/div[6]/div/div
    ${D_NUMBER}  convert to integer  ${Count}
    ${RANDOM_DEVICE}=  gettingList  ${D_NUMBER}

    wait until element is visible  ${RANDOM_DEVICE}
    wait until keyword succeeds  3  1  click element  ${RANDOM_DEVICE}

    wait until element is visible  ${continue_button1}
    wait until keyword succeeds  3  1  click element  ${continue_button1}

Random Price Plan
     wait until element is visible  ${back_button}
     ${Count_Tariff}=  Get matching xpath count  //*[@id='pricePlanTable']/tbody/tr /td[5]/a
     ${T_NUMBER}  convert to integer  ${Count_Tariff}
     log to console  ${T_NUMBER}

     ${RANDOM_TARIFF}=  gettingTariff   ${T_NUMBER}

     wait until element is visible  ${RANDOM_TARIFF}
     wait until keyword succeeds  3  1  click element  ${RANDOM_TARIFF}

     wait until keyword succeeds  3  1  click element  ${TC_CHECKBOX}
    # click element  ${TC_CHECKBOX}

     wait until element is enabled  ${TC_CHECKBOX}

     click element  ${CONTINUE_BUTTON_P}

Random Addon

    wait until element is visible  ${back_button}
    ${Count_Addon}=  Get matching xpath count  //*[@id='pricePlanTable']/tbody/tr /td[4]/a
    ${A_NUMBER}  convert to integer  ${Count_Addon}
    log to console  ${A_NUMBER}

    ${RANDOM_ADDON}=  gettingAddon  ${A_NUMBER}

    wait until element is enabled   ${RANDOM_ADDON}
    wait until keyword succeeds  3  1  click element  ${RANDOM_ADDON}
    wait until keyword succeeds  3  1  click element  ${CONTINUE_ADDON}

Insurance Window

    run keyword and ignore error  wait until element is visible  ${INSURANCE_BACK}


    #wait until element is visible  ${CONTINUE_INSURANCE}
   #run keyword and expect error  StaleElementReferenceException  click element  ${CONTINUE_INSURANCE}
   run keyword and ignore error  wait until keyword succeeds  3  1  click element  ${CONTINUE_INSURANCE}




   #wait until keyword succeeds  3  1  click element  ${CONTINUE_INSURANCE}

Personal Details Page
     wait until element is visible  ${submit_button}

   #  mouse out  ${submit_button}

    # click element at coordinates  ${SUBMIT_BUTTON}  30  100000


    wait until keyword succeeds  3  1  click element  ${EXTRA_SIM}
    press key  ${extra_sim_field}  no
    press key  ${EXTRA_SIM_FIELD}  \\13

    wait until keyword succeeds  3  1  click element  ${pd_tc}

     wait until keyword succeeds  3  1  click element  ${submit_button}

Order confirm
    set screenshot directory  /screenshot
    ${DT} =  Get current Date  result_format=%d_%m_%Y_%H_%M_
    take screenshot  ${DT}contract






*** Test Cases ***
test
    Open Browser to Eligibility
    mobile form
    Random Device
    Random Price Plan
    Random Addon
   Insurance Window
    personal details page
    order confirm


  [Teardown]


