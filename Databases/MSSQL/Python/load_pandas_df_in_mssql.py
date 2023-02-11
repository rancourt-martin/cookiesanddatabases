# https://learn.microsoft.com/en-us/sql/machine-learning/data-exploration/python-dataframe-sql-server?view=sql-server-ver16

import pyodbc as db
import pandas as pd
# insert data from csv file into dataframe.
# working directory for csv file: type "pwd" in Azure Data Studio or Linux
# working directory in Windows c:\users\username
#df = pd.read_csv("c:\\user\\username\department.csv")
try:
  df = pd.read_csv("C:\\Users\\marti\\Documents\\source\\mdr-helpers\\Databases\\MSSQL\\python\\1810000101_databaseLoadingData.csv", dtype=object, na_filter = False)
  #df.fillna(0)
  # Some other example server values are
  # server = 'localhost\sqlexpress' # for a named instance
  # server = 'myserver,port' # to specify an alternate port
  server = 'rocky01' 
  database = 'DINTINO' 
  username = 'dintino_rw' 
  password = 'b8dRfDT1$' 
  cnxn = db.connect('DRIVER={SQL Server};SERVER='+server+';DATABASE='+database+';UID='+username+';PWD='+ password)
  cnxn.setdecoding(db.SQL_CHAR, encoding='latin1')
  cnxn.setencoding('latin1')
  cursor = cnxn.cursor()
  # Insert Dataframe into SQL Server:
  #for index, row in df.iterrows():
  for row in df.itertuples():
       #cursor.execute("INSERT INTO  (DepartmentID,Name,GroupName) values(?,?,?)", row.DepartmentID, row.Name, row.GroupName)
       #print(row.REF_DATE,row.GEO,row.DGUID,row.Type_of_fuel,row.UOM,row.UOM_ID,row.SCALAR_FACTOR,row.SCALAR_ID,row.VECTOR,row.COORDINATE,row.VALUE,row.DECIMALS)

#      print(row)

       cursor.execute("""INSERT INTO [dbo].[monthly_average_retail_prices_for_gasoline]
           ([REF_DATE]
           ,[GEO]
           ,[DGUID]
           ,[Type of fuel]
           ,[UOM]
           ,[UOM_ID]
           ,[SCALAR_FACTOR]
           ,[VECTOR]
           ,[COORDINATE]
           ,[VALUE]
           ,[DECIMALS])
     VALUES
           (?,
           ?,
           ?,
           ?,
           ?,
           ?,
           ?,
           ?,
           ?,
           ?,
           ?)""",row.REF_DATE,row.GEO,row.DGUID,row.Type_of_fuel,row.UOM,row.UOM_ID,row.SCALAR_FACTOR,row.VECTOR,row.COORDINATE,row.VALUE,row.DECIMALS)

except db.Error as ex:
  sqlstate = ex.args[1]
  print(sqlstate) 
  print(ex.args)

finally:
  cnxn.commit()
