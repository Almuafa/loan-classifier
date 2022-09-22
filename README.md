# Loan classifier
Building classifier that predicts ability of consumer to pay the loan 

## Workflow
1. Data gathering
2. Exploratory data analysis (EDA)
3. Data Wrangling (cleansing, transforming, standardization, normalization)
4. Training
5. Predict
6. Inference
7. Tableau dashboard

### 1. Data gathering
I used this website https://relational.fit.cvut.cz/dataset/Financial to get the database, I choised the Financial database to work with ,
and then I used this website https://web.archive.org/web/20180506035658/http://lisp.vse.cz/pkdd99/Challenge/berka.htm to understand the data dictionary.
And then I connected the database to MySQL and Jupyter Notebooks so I created some function to get the data from database  
#### Create_db_connection
this function to connect the database
#### read_query
function to read the query

finaly I connected the database to Tableau 

### 2. Exploratory data analysis (EDA)
I Used MySQL to manipulate , understand and prepare the necessary tables ;
I used Python primarily the pandas package to wrangle and visualize data to gain preliminary insights;
I used Tableau to create a comprehensive and automated dashboards and data story for better understand and analyze the data in each table 
and then decide this

Problem Formulation
 1. I want to investigate "what factors/variables affect a good or a bad loan"
 2. Make predictions whether a customer should get its loan approved or not based on their characteristics
 3. Hence our Dependent variable (y) is the Loan Approval (Yes/No) or if the Loan is Good or Bad

### 3. Data Wrangling (cleansing, transforming, standardization, normalization)
After I loaded the data to Jupyter notebooks:
1. I took a look to data and I checked for missing and outliers data to treat them.
2. I dropped some unnecessary columns like 'account id','client id','card type','card issued','loan id'.
3. I change the data type for dates columns to datetime so I created 
    #### split_dates 
    function to create column year , month and day and dropped the dates columns.
5. I changed the category columns to Categorical type to change them to numbers.
6. After I have been sure all columns are integers or floats I extract all rows that had loans to train the machine learning.
7. I spleated the data into Inputs X and outputs Y.  
8. I used 'StandardScaler' library form 'sklearn.preprocessing' to standardized the Inputs data.
9. I spleated the data to train data 80% and test data 20% using 'train_test_split' library form 'sklearn.model_selection'.

### 4. Training
I provided all of the training data to a learning algorithm and let the learning algorithm to discover the mapping between the inputs and the output class using 'LogisticRegression' from 'sklearn.linear_model' and I called the fit() function and passing in the training dataset.

### 5. Predict
Finally, we can evaluate the model by first using it to make predictions on the training dataset by calling predict() and then comparing the predictions to the expected class labels and calculating the accuracy.
I use 'model.score' to check the Accuracy of the model

### 6. Inference
Finally I check the importance of all the feature I found the loan amount is the most important feature from all other feature based on the database.

### 7. Tableau dashboard

Please see the full Tableau Financial Project from my account in Tableau Public using this link :
https://public.tableau.com/app/profile/ahmed1792

## Usage
Please run the script using the following command

```python
python pull.py
```
*alternatively you can run the jupyter notebook `classify good and bad loan machine learning.ipynb` and `financial Project Analysis.ipynb` included as part of the repo*

## References
This repo used the following references in coming up with all code etc.,
- https://www.mysql.com/
- https://relational.fit.cvut.cz/dataset/Financial
- https://web.archive.org/web/20180506035658/http://lisp.vse.cz/pkdd99/Challenge/berka.htm
- https://docs.python.org/3/library/functions.html#open
- https://pandas.pydata.org/
- https://numpy.org/
- https://matplotlib.org/
- https://seaborn.pydata.org/
- https://www.tableau.com/
- https://www.w3schools.com/python/python_lists.asp
- https://stackoverflow.com/

## Feedback
Please create GitHub issues, if you find any issues or bugs or ideas to improve upon
