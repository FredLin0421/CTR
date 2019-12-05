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
indeps.add_output('length1', np.ones(10))
indeps.add_output('length2', np.ones(10))
"""indeps.add_output('length3', np.ones(10))"""
indeps.add_output('length4', np.ones(10))
"""indeps.add_output('kappa1', 1)"""
indeps.add_output('kappa2', 1)
"""indeps.add_output('kappa3', 1)"""
indeps.add_output('kb1', 1)
indeps.add_output('kb2', 1)
indeps.add_output('kb3', 1)
indeps.add_output('l22', np.ones(10))
indeps.add_output('psi2', np.ones(10))


prob.model.add_subsystem('parab', Paraboloid())

# define the component whose output will be constrained
#prob.model.add_subsystem('C1', om.ExecComp('y=sum(l22)*2.0', x=np.zeros(10)))
prob.model.add_subsystem('const1', om.ExecComp('x = length1*(cos((kappa2*kb2*(l22 - length2))/(kb1 + kb2 + kb3))*cos(psi2)*sin((kappa2*kb2*(length2))/(kb1 + kb2)) + sin((kappa2*kb2*(l22 - length2))/(kb1 + kb2 + kb3))*cos((kappa2*kb2*(length2))/(kb1 + kb2))*cos(psi2)) - (cos(psi2)*(cos((kappa2*kb2*(l22 - length2))/(kb1 + kb2 + kb3)) - 1)*(kb1 + kb2 + kb3))/(kappa2*kb2) - (cos((kappa2*kb2*(l22 - length2))/(kb1 + kb2 + kb3))*cos(psi2)*(cos((kappa2*kb2*(length2))/(kb1 + kb2)) - 1)*(kb1 + kb2))/(kappa2*kb2) + (sin((kappa2*kb2*(l22 - length2))/(kb1 + kb2 + kb3))*cos(psi2)*sin((kappa2*kb2*(length2))/(kb1 + kb2))*(kb1 + kb2))/(kappa2*kb2)',x=np.zeros(10),l22=np.zeros(10),length2=np.zeros(10),length1=np.zeros(10),psi2=np.zeros(10)))
prob.model.add_subsystem('const2', om.ExecComp('y = length1*(cos((kappa2*kb2*(l22 - length2))/(kb1 + kb2 + kb3))*sin((kappa2*kb2*(length2))/(kb1 + kb2))*sin(psi2) + sin((kappa2*kb2*(l22 - length2))/(kb1 + kb2 + kb3))*cos((kappa2*kb2*(length2))/(kb1 + kb2))*sin(psi2)) - (sin(psi2)*(cos((kappa2*kb2*(l22 - length2))/(kb1 + kb2 + kb3)) - 1)*(kb1 + kb2 + kb3))/(kappa2*kb2) - (cos((kappa2*kb2*(l22 - length2))/(kb1 + kb2 + kb3))*sin(psi2)*(cos((kappa2*kb2*(length2))/(kb1 + kb2)) - 1)*(kb1 + kb2))/(kappa2*kb2) + (sin((kappa2*kb2*(l22 - length2))/(kb1 + kb2 + kb3))*sin((kappa2*kb2*(length2))/(kb1 + kb2))*sin(psi2)*(kb1 + kb2))/(kappa2*kb2)',y=np.zeros(10),l22=np.zeros(10),length2=np.zeros(10),length1=np.zeros(10),psi2=np.zeros(10)))
prob.model.add_subsystem('const3', om.ExecComp('z = length4 + length1*(cos((kappa2*kb2*(l22 - length2))/(kb1 + kb2 + kb3))*cos((kappa2*kb2*(length2))/(kb1 + kb2)) - sin((kappa2*kb2*(l22 - length2))/(kb1 + kb2 + kb3))*sin((kappa2*kb2*(length2))/(kb1 + kb2))) + (sin((kappa2*kb2*(l22 - length2))/(kb1 + kb2 + kb3))*(kb1 + kb2 + kb3))/(kappa2*kb2) + (cos((kappa2*kb2*(l22 - length2))/(kb1 + kb2 + kb3))*sin((kappa2*kb2*(length2))/(kb1 + kb2))*(kb1 + kb2))/(kappa2*kb2) + (sin((kappa2*kb2*(l22 - length2))/(kb1 + kb2 + kb3))*(cos((kappa2*kb2*(length2))/(kb1 + kb2)) - 1)*(kb1 + kb2))/(kappa2*kb2)',z=np.zeros(10),l22=np.zeros(10),length4=np.zeros(10),length1=np.zeros(10),length2=np.zeros(10)))
prob.model.add_subsystem('const4', om.ExecComp('g=l22-length2', g=np.zeros(10),l22=np.zeros(10),length2=np.zeros(10)))
prob.model.add_subsystem('const5', om.ExecComp('k=kb3-kb2'))
prob.model.add_subsystem('const6', om.ExecComp('k2=kb2-kb1'))
#prob.model.add_subsystem('const7', om.ExecComp('l23=l22-length3-length3',l23=np.zeros(10),l22=np.zeros(10),length3=np.zeros(10)))




prob.model.connect('indeps.l22', ['parab.l22','const1.l22','const2.l22','const3.l22','const4.l22'])
prob.model.connect('indeps.length1', ['parab.length1','const1.length1','const2.length1','const3.length1'])
prob.model.connect('indeps.length2', ['parab.length2','const1.length2','const2.length2','const3.length2','const4.length2'])
prob.model.connect('indeps.length4', ['parab.length4','const3.length4'])
"""prob.model.connect('indeps.kappa1', ['parab.kappa1','const1.kappa1','const2.kappa1'])"""
prob.model.connect('indeps.kappa2', ['parab.kappa2','const1.kappa2','const2.kappa2','const3.kappa2'])
"""prob.model.connect('indeps.kappa3', ['parab.kappa3','const1.kappa3','const2.kappa3'])"""
prob.model.connect('indeps.kb1', ['parab.kb1','const1.kb1','const2.kb1','const3.kb1','const6.kb1'])
prob.model.connect('indeps.kb2', ['parab.kb2','const1.kb2','const2.kb2','const3.kb2','const5.kb2','const6.kb2'])
prob.model.connect('indeps.kb3', ['parab.kb3','const1.kb3','const2.kb3','const3.kb3','const5.kb3'])
prob.model.connect('indeps.psi2', ['parab.psi2','const1.psi2','const2.psi2'])


# setup the optimization
prob.driver = om.ScipyOptimizeDriver()
prob.driver.options['optimizer'] = 'SLSQP'
"""prob.driver.options['maxiter'] = 500"""

prob.model.add_design_var('indeps.length1', lower=1, upper=100)
prob.model.add_design_var('indeps.length2', lower=1, upper=100)
prob.model.add_design_var('indeps.length4', lower=1, upper=100)
"""prob.model.add_design_var('indeps.kappa1', lower=0, upper=10)"""
prob.model.add_design_var('indeps.kappa2', lower=0, upper=0.5)
"""prob.model.add_design_var('indeps.kappa3', lower=0, upper=10)"""
prob.model.add_design_var('indeps.kb1', lower=1, upper=25)
prob.model.add_design_var('indeps.kb2', lower=1, upper=25)
prob.model.add_design_var('indeps.kb3', lower=1, upper=50)
prob.model.add_design_var('indeps.l22', lower=1, upper=100)
prob.model.add_design_var('indeps.psi2', lower=0)

prob.model.add_objective('parab.f_xy')


# Taks : Define the constraint curvature for tube two

# to add the constraint to the model
"""
prob.model.add_constraint('const1.x', lower=29.5, upper=30.0)
prob.model.add_constraint('const2.y', lower=29.5, upper=30.0)"""
prob.model.add_constraint('const1.x', equals=[30,20,25,22,23,24,35,28,21,26])
prob.model.add_constraint('const2.y', equals=[0,0,0,0,0,0,0,0,0,0])
prob.model.add_constraint('const3.z', equals=[80,80,80,80,80,80,80,80,80,80])
prob.model.add_constraint('const4.g', lower=0)
prob.model.add_constraint('const5.k', lower=0)
prob.model.add_constraint('const6.k2', lower=0)
#prob.model.add_constraint('const7.l23', lower=0)
prob.setup()
prob.run_driver()

# minimum value
#print(prob['parab.f_xy'])

# location of the minimum
print('Length1 =',prob['indeps.length1'])
print('Length3 =',prob['indeps.l22']-prob['indeps.length2'])
print('Length2 =',prob['indeps.length2'])
print('Length4 =',prob['indeps.length4'])
print('kappa2 = ',prob['indeps.kappa2'])
print('kb1 = ',prob['indeps.kb1'])
print('kb2 = ',prob['indeps.kb2'])
print('kb3 = ',prob['indeps.kb3'])
print('l22 = ',prob['indeps.l22'])
print('psi2 = ',prob['indeps.psi2'])

