#!/usr/bin/env python
# coding: utf-8

# In[1]:


import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns
from scipy.stats import chi2_contingency
import scipy.stats as stats



# In[2]:


def fill_mean(data, columns):
    """
    data: dataframe
    columns: columns
    return: modified dataframe with mean filled 
    """
    
    for col in columns:
        mean_value = data[columns].mean()
        data[columns] = data[columns].fillna(mean_value)
    
    return data


# In[3]:


def barplot_cat(data):
    """
    data: dataframe
    return: countplots of categorical columns
    """
    for column in data.select_dtypes(np.object):
        sns.countplot(column, data = data, color = 'skyblue')
        results = plt.show()
    return results


# In[4]:


def pie_columns(columns):
    """
    return: pie charts of selected columns
    """
    for col in columns:
        plt.pie(data[col].value_counts(), autopct='%1.0f%%')
        plt.title(col)
        results = plt.show()
    return results


# In[5]:


def barplot_specific_columns(columns):
    """
    return: barplots of selected columns
    """
    for col in columns:
        sns.countplot(col, data = data_vis, palette = 'rainbow')
        results = plt.show()
    return results


# In[6]:


def displot_columns(columns):
    """
    return: displots of selected columns
    """
    for col in columns:
        sns.displot(data_vis[col])
        results = plt.show()
    return results


# In[7]:


def countplot_columns(columns):
    """
    return: count plots of selected columns
    """
    for i in columns:
        sns.countplot(x = i, hue = 'offer_accepted', data = data_vis, palette = 'rainbow' )
        results = plt.show()
    return results


# In[8]:


def col_cat_val(cols):
    """
    return: Chisquare test results
    """
    for i in cols:
        for j in cols:
            if i != j:
                data_crosstab = pd.crosstab(data[i], data[j], margins = False)
                result = chi2_contingency(data_crosstab, correction=False)
                print('Result for', i, '&', j, ':', result )
    
    return 


# In[9]:


def boxcox_transform(data1):
    numeric_cols = data1.select_dtypes(np.number).columns
    _ci = {column: None for column in numeric_cols}
    for column in numeric_cols:
        # since i know any columns should take negative numbers, to avoid -inf in df
        data1[column] = np.where(data1[column]<=0, np.NAN, data1[column]) 
        data1[column] = data1[column].fillna(data1[column].mean())
        #print(column)
        transformed_data, ci = stats.boxcox(data1[column])
        data1[column] = transformed_data
        _ci[column] = [ci] 
    return data1, _ci


# In[10]:


def remove_outliers(data1, threshold=1.5, in_columns=data1.select_dtypes(np.number).columns, skip_columns=[]):
    for column in in_columns:
        if column not in skip_columns:
            upper = np.percentile(data1[column],75)
            lower = np.percentile(data1[column],25)
            iqr = upper - lower
            upper_limit = upper + (threshold * iqr)
            lower_limit = lower - (threshold * iqr)
            data1 = data1[(data1[column]>lower_limit) & (data1[column]<upper_limit)]
    return data1

