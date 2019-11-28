# -*- coding: utf-8 -*-
"""
Created on Tue Nov 26 17:03:44 2019

@author: Morimoto Lab
"""
import openmdao.api as om
import numpy as np
from model import Paraboloid

# We'll use the component that was defined in the last tutorial


# build the model
prob = om.Problem()
indeps = prob.model.add_subsystem('indeps', om.IndepVarComp())
"""indeps.add_output('x', 3.0)
indeps.add_output('y', -4.0)"""
indeps.add_output('length1', 1)
"""ivc.add_output('length2', 1.0)"""
indeps.add_output('length3', 1)
indeps.add_output('length4', 1)
"""indeps.add_output('kappa1', 1)"""
indeps.add_output('kappa2', 1)
indeps.add_output('kappa3', 1)
indeps.add_output('kb1', 1)
indeps.add_output('kb2', 1)
indeps.add_output('kb3', 1)
indeps.add_output('l22', 1)

prob.model.add_subsystem('parab', Paraboloid())

# define the component whose output will be constrained
prob.model.add_subsystem('const1', om.ExecComp('g = length1*(cos((length3*(kappa1*kb1 + kappa2*kb2 + kappa3*kb3))/(kb1 + kb2 + kb3))*sin(((l22 - length3)*(kappa1*kb1 + kappa2*kb2))/(kb1 + kb2)) + sin((length3*(kappa1*kb1 + kappa2*kb2 + kappa3*kb3))/(kb1 + kb2 + kb3))*cos(((l22 - length3)*(kappa1*kb1 + kappa2*kb2))/(kb1 + kb2))) - ((cos((length3*(kappa1*kb1 + kappa2*kb2 + kappa3*kb3))/(kb1 + kb2 + kb3)) - 1)*(kb1 + kb2 + kb3))/(kappa1*kb1 + kappa2*kb2 + kappa3*kb3) - (cos((length3*(kappa1*kb1 + kappa2*kb2 + kappa3*kb3))/(kb1 + kb2 + kb3))*(cos(((l22 - length3)*(kappa1*kb1 + kappa2*kb2))/(kb1 + kb2)) - 1)*(kb1 + kb2))/(kappa1*kb1 + kappa2*kb2) + (sin((length3*(kappa1*kb1 + kappa2*kb2 + kappa3*kb3))/(kb1 + kb2 + kb3))*sin(((l22 - length3)*(kappa1*kb1 + kappa2*kb2))/(kb1 + kb2))*(kb1 + kb2))/(kappa1*kb1 + kappa2*kb2)'))
prob.model.add_subsystem('const2', om.ExecComp('g =  length4 + length1*(cos((length3*(kappa1*kb1 + kappa2*kb2 + kappa3*kb3))/(kb1 + kb2 + kb3))*cos(((l22 - length3)*(kappa1*kb1 + kappa2*kb2))/(kb1 + kb2)) - sin((length3*(kappa1*kb1 + kappa2*kb2 + kappa3*kb3))/(kb1 + kb2 + kb3))*sin(((l22 - length3)*(kappa1*kb1 + kappa2*kb2))/(kb1 + kb2))) + (sin((length3*(kappa1*kb1 + kappa2*kb2 + kappa3*kb3))/(kb1 + kb2 + kb3))*(kb1 + kb2 + kb3))/(kappa1*kb1 + kappa2*kb2 + kappa3*kb3) + (sin((length3*(kappa1*kb1 + kappa2*kb2 + kappa3*kb3))/(kb1 + kb2 + kb3))*(cos(((l22 - length3)*(kappa1*kb1 + kappa2*kb2))/(kb1 + kb2)) - 1)*(kb1 + kb2))/(kappa1*kb1 + kappa2*kb2) + (cos((length3*(kappa1*kb1 + kappa2*kb2 + kappa3*kb3))/(kb1 + kb2 + kb3))*sin(((l22 - length3)*(kappa1*kb1 + kappa2*kb2))/(kb1 + kb2))*(kb1 + kb2))/(kappa1*kb1 + kappa2*kb2)'))
prob.model.add_subsystem('const3', om.ExecComp('g = l22 - length3'))
'''prob.model.connect('indeps.x', ['parab.x', 'const.x'])
prob.model.connect('indeps.y', ['parab.y', 'const.y'])'''

prob.model.connect('indeps.l22', ['parab.l22','const1.l22','const2.l22','const3.l22'])
prob.model.connect('indeps.length1', ['parab.length1','const1.length1','const2.length1'])
prob.model.connect('indeps.length3', ['parab.length3','const1.length3','const2.length3','const3.length3'])
prob.model.connect('indeps.length4', ['parab.length4','const2.length4'])
"""prob.model.connect('indeps.kappa1', ['parab.kappa1','const1.kappa1','const2.kappa1'])"""
prob.model.connect('indeps.kappa2', ['parab.kappa2','const1.kappa2','const2.kappa2'])
prob.model.connect('indeps.kappa3', ['parab.kappa3','const1.kappa3','const2.kappa3'])
prob.model.connect('indeps.kb1', ['parab.kb1','const1.kb1','const2.kb1'])
prob.model.connect('indeps.kb2', ['parab.kb2','const1.kb2','const2.kb2'])
prob.model.connect('indeps.kb3', ['parab.kb3','const1.kb3','const2.kb3'])

# setup the optimization
prob.driver = om.ScipyOptimizeDriver()
prob.driver.options['optimizer'] = 'SLSQP'
"""prob.driver.options['maxiter'] = 500"""

prob.model.add_design_var('indeps.length1', lower=1, upper=50)
prob.model.add_design_var('indeps.length3', lower=1, upper=50)
prob.model.add_design_var('indeps.length4', lower=1, upper=50)
"""prob.model.add_design_var('indeps.kappa1', lower=0, upper=10)"""
prob.model.add_design_var('indeps.kappa2', lower=0, upper=10)
prob.model.add_design_var('indeps.kappa3', lower=0, upper=10)
prob.model.add_design_var('indeps.kb1', lower=1, upper=50)
prob.model.add_design_var('indeps.kb2', lower=1, upper=50)
prob.model.add_design_var('indeps.kb3', lower=1, upper=50)
prob.model.add_design_var('indeps.l22', lower=1, upper=50)
prob.model.add_objective('parab.f_xy')

# to add the constraint to the model
"""
prob.model.add_constraint('const1.g', lower=29.5, upper=30.0)
prob.model.add_constraint('const2.g', lower=29.5, upper=30.0)"""
prob.model.add_constraint('const1.g', equals=30)
prob.model.add_constraint('const2.g', equals=30)
prob.model.add_constraint('const3.g', lower=1, upper=30)

prob.setup()
prob.run_driver()

# minimum value
#print(prob['parab.f_xy'])

# location of the minimum
print('Length1 =',prob['indeps.length1'])
print('Length2 =',prob['indeps.l22']-prob['indeps.length3'])
print('Length3 =',prob['indeps.length3'])
print('Length4 =',prob['indeps.length4'])
print('kappa1 = [0]')
print('kappa2 = ',prob['indeps.kappa2'])
print('kappa3 = ',prob['indeps.kappa3'])
print('kb1 = ',prob['indeps.kb1'])
print('kb2 = ',prob['indeps.kb2'])
print('kb3 = ',prob['indeps.kb3'])
print('l22 = ',prob['indeps.l22'])

