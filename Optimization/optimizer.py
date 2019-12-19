# -*- coding: utf-8 -*-
"""
Created on Tue Nov 26 17:03:44 2019

@author: Morimoto Lab
"""
import openmdao.api as om
import numpy as np
from model import CTR
import h5py
import time


t0=time.time()
# Load the path point
f = h5py.File('path.mat','r')
data_pa = f.get('Pa')
data_pb = f.get('Pb')
data_pa = np.array(data_pa)
data_pb = np.array(data_pb)
# Adjust the base position of the concentric tube robot
data_pa[0] = data_pa[0] + 40
data_pa[2] = data_pa[2] - 100

# We'll use the component that was defined in the last tutorial

dim = np.shape(data_pa)
N = dim[1]
E =80
# build the model
prob = om.Problem()
indeps = prob.model.add_subsystem('indeps', om.IndepVarComp())
"""indeps.add_output('x', 3.0)
indeps.add_output('y', -4.0)"""
indeps.add_output('length1', np.ones(N)*-20 )
indeps.add_output('length2', np.ones(N)*-20)
"""indeps.add_output('length3', np.ones(10))"""
indeps.add_output('length4', np.ones(N)*-20)
"""indeps.add_output('kappa1', 1)"""
indeps.add_output('kappa2', .1)
"""indeps.add_output('kappa3', 1)"""
#indeps.add_output('E*pi*(d2**4-d1**4)/64', 1)
#indeps.add_output('E*pi*(d4**4-d3**4)/64', 1)
#indeps.add_output('E*pi*(d6**4-d5**4)/64', 1)
indeps.add_output('l22', np.ones(N)*-10)
indeps.add_output('psi2', np.ones(N))
indeps.add_output('d1', 0.6)
indeps.add_output('d2', 1.0)
indeps.add_output('d3', 1.1)
indeps.add_output('d4', 1.7)
indeps.add_output('d5', 2)
indeps.add_output('d6', 2.1)



prob.model.add_subsystem('ctr', CTR())

# define the component whose output will be constrained
prob.model.add_subsystem('const1', om.ExecComp('x = length1*(cos(((kappa2*E*pi*(d4**4-d3**4)/64)*(l22 - length2))/(E*pi*(d2**4-d1**4)/64 + E*pi*(d4**4-d3**4)/64 + E*pi*(d6**4-d5**4)/64))*cos(psi2)*sin(((kappa2*E*pi*(d4**4-d3**4)/64)*(length2))/(E*pi*(d2**4-d1**4)/64 + E*pi*(d4**4-d3**4)/64)) + sin(((kappa2*E*pi*(d4**4-d3**4)/64)*(l22 - length2))/(E*pi*(d2**4-d1**4)/64 + E*pi*(d4**4-d3**4)/64 + E*pi*(d6**4-d5**4)/64))*cos(((kappa2*E*pi*(d4**4-d3**4)/64)*(length2))/(E*pi*(d2**4-d1**4)/64 + E*pi*(d4**4-d3**4)/64))*cos(psi2)) - (cos(psi2)*(cos(((kappa2*E*pi*(d4**4-d3**4)/64)*(l22 - length2))/(E*pi*(d2**4-d1**4)/64 + E*pi*(d4**4-d3**4)/64 + E*pi*(d6**4-d5**4)/64)) - 1)*(E*pi*(d2**4-d1**4)/64 + E*pi*(d4**4-d3**4)/64 + E*pi*(d6**4-d5**4)/64))/(kappa2*E*pi*(d4**4-d3**4)/64) - (cos(((kappa2*E*pi*(d4**4-d3**4)/64)*(l22 - length2))/(E*pi*(d2**4-d1**4)/64 + E*pi*(d4**4-d3**4)/64 + E*pi*(d6**4-d5**4)/64))*cos(psi2)*(cos(((kappa2*E*pi*(d4**4-d3**4)/64)*(length2))/(E*pi*(d2**4-d1**4)/64 + E*pi*(d4**4-d3**4)/64)) - 1)*(E*pi*(d2**4-d1**4)/64 + E*pi*(d4**4-d3**4)/64))/(kappa2*E*pi*(d4**4-d3**4)/64) + (sin(((kappa2*E*pi*(d4**4-d3**4)/64)*(l22 - length2))/(E*pi*(d2**4-d1**4)/64 + E*pi*(d4**4-d3**4)/64 + E*pi*(d6**4-d5**4)/64))*cos(psi2)*sin(((kappa2*E*pi*(d4**4-d3**4)/64)*(length2))/(E*pi*(d2**4-d1**4)/64 + E*pi*(d4**4-d3**4)/64))*(E*pi*(d2**4-d1**4)/64 + E*pi*(d4**4-d3**4)/64))/(kappa2*E*pi*(d4**4-d3**4)/64)',x=np.zeros(N),l22=np.zeros(N),length2=np.zeros(N),length1=np.zeros(N),psi2=np.zeros(N)))
prob.model.add_subsystem('const2', om.ExecComp('y = length1*(cos(((kappa2*E*pi*(d4**4-d3**4)/64)*(l22 - length2))/(E*pi*(d2**4-d1**4)/64 + E*pi*(d4**4-d3**4)/64 + E*pi*(d6**4-d5**4)/64))*sin((kappa2*E*pi*(d4**4-d3**4)/64*(length2))/(E*pi*(d2**4-d1**4)/64 + E*pi*(d4**4-d3**4)/64))*sin(psi2) + sin(((kappa2*E*pi*(d4**4-d3**4)/64)*(l22 - length2))/(E*pi*(d2**4-d1**4)/64 + E*pi*(d4**4-d3**4)/64 + E*pi*(d6**4-d5**4)/64))*cos(((kappa2*E*pi*(d4**4-d3**4)/64)*(length2))/(E*pi*(d2**4-d1**4)/64 + E*pi*(d4**4-d3**4)/64))*sin(psi2)) - (sin(psi2)*(cos(((kappa2*E*pi*(d4**4-d3**4)/64)*(l22 - length2))/(E*pi*(d2**4-d1**4)/64 + E*pi*(d4**4-d3**4)/64 + E*pi*(d6**4-d5**4)/64)) - 1)*(E*pi*(d2**4-d1**4)/64 + E*pi*(d4**4-d3**4)/64 + E*pi*(d6**4-d5**4)/64))/(kappa2*E*pi*(d4**4-d3**4)/64) - (cos(((kappa2*E*pi*(d4**4-d3**4)/64)*(l22 - length2))/(E*pi*(d2**4-d1**4)/64 + E*pi*(d4**4-d3**4)/64 + E*pi*(d6**4-d5**4)/64))*sin(psi2)*(cos(((kappa2*E*pi*(d4**4-d3**4)/64)*(length2))/(E*pi*(d2**4-d1**4)/64 + E*pi*(d4**4-d3**4)/64)) - 1)*(E*pi*(d2**4-d1**4)/64 + E*pi*(d4**4-d3**4)/64))/(kappa2*E*pi*(d4**4-d3**4)/64) + (sin(((kappa2*E*pi*(d4**4-d3**4)/64)*(l22 - length2))/(E*pi*(d2**4-d1**4)/64 + E*pi*(d4**4-d3**4)/64 + E*pi*(d6**4-d5**4)/64))*sin(((kappa2*E*pi*(d4**4-d3**4)/64)*(length2))/(E*pi*(d2**4-d1**4)/64 + E*pi*(d4**4-d3**4)/64))*sin(psi2)*(E*pi*(d2**4-d1**4)/64 + E*pi*(d4**4-d3**4)/64))/(kappa2*E*pi*(d4**4-d3**4)/64)',y=np.zeros(N),l22=np.zeros(N),length2=np.zeros(N),length1=np.zeros(N),psi2=np.zeros(N)))
prob.model.add_subsystem('const3', om.ExecComp('z = length4 + length1*(cos(((kappa2*E*pi*(d4**4-d3**4)/64)*(l22 - length2))/(E*pi*(d2**4-d1**4)/64 + E*pi*(d4**4-d3**4)/64 + E*pi*(d6**4-d5**4)/64))*cos(((kappa2*E*pi*(d4**4-d3**4)/64)*(length2))/(E*pi*(d2**4-d1**4)/64 + E*pi*(d4**4-d3**4)/64)) - sin(((kappa2*E*pi*(d4**4-d3**4)/64)*(l22 - length2))/(E*pi*(d2**4-d1**4)/64 + E*pi*(d4**4-d3**4)/64 + E*pi*(d6**4-d5**4)/64))*sin(((kappa2*E*pi*(d4**4-d3**4)/64)*(length2))/(E*pi*(d2**4-d1**4)/64 + E*pi*(d4**4-d3**4)/64))) + (sin(((kappa2*E*pi*(d4**4-d3**4)/64)*(l22 - length2))/(E*pi*(d2**4-d1**4)/64 + E*pi*(d4**4-d3**4)/64 + E*pi*(d6**4-d5**4)/64))*(E*pi*(d2**4-d1**4)/64 + E*pi*(d4**4-d3**4)/64 + E*pi*(d6**4-d5**4)/64))/(kappa2*E*pi*(d4**4-d3**4)/64) + (cos(((kappa2*E*pi*(d4**4-d3**4)/64)*(l22 - length2))/(E*pi*(d2**4-d1**4)/64 + E*pi*(d4**4-d3**4)/64 + E*pi*(d6**4-d5**4)/64))*sin(((kappa2*E*pi*(d4**4-d3**4)/64)*(length2))/(E*pi*(d2**4-d1**4)/64 + E*pi*(d4**4-d3**4)/64))*(E*pi*(d2**4-d1**4)/64 + E*pi*(d4**4-d3**4)/64))/(kappa2*E*pi*(d4**4-d3**4)/64) + (sin(((kappa2*E*pi*(d4**4-d3**4)/64)*(l22 - length2))/(E*pi*(d2**4-d1**4)/64 + E*pi*(d4**4-d3**4)/64 + E*pi*(d6**4-d5**4)/64))*(cos(((kappa2*E*pi*(d4**4-d3**4)/64)*(length2))/(E*pi*(d2**4-d1**4)/64 + E*pi*(d4**4-d3**4)/64)) - 1)*(E*pi*(d2**4-d1**4)/64 + E*pi*(d4**4-d3**4)/64))/(kappa2*E*pi*(d4**4-d3**4)/64)',z=np.zeros(N),l22=np.zeros(N),length4=np.zeros(N),length1=np.zeros(N),length2=np.zeros(N)))
prob.model.add_subsystem('const4', om.ExecComp('g=l22-length2', g=np.zeros(N),l22=np.zeros(N),length2=np.zeros(N)))
prob.model.add_subsystem('const5', om.ExecComp('t1=d2-d1'))
prob.model.add_subsystem('const6', om.ExecComp('t2=d4-d3'))
prob.model.add_subsystem('const7', om.ExecComp('t3=d6-d5'))
prob.model.add_subsystem('const8', om.ExecComp('t12=d3-d2')) 
prob.model.add_subsystem('const9', om.ExecComp('t23=d5-d4'))
prob.model.add_subsystem('const10', om.ExecComp('k1=E*pi*(d2**4-d1**4)/64'))
prob.model.add_subsystem('const11', om.ExecComp('k2=E*pi*(d4**4-d3**4)/64'))
prob.model.add_subsystem('const12', om.ExecComp('k3=E*pi*(d6**4-d5**4)/64'))





prob.model.connect('indeps.l22', ['ctr.l22','const1.l22','const2.l22','const3.l22','const4.l22'])
prob.model.connect('indeps.length1', ['ctr.length1','const1.length1','const2.length1','const3.length1'])
prob.model.connect('indeps.length2', ['ctr.length2','const1.length2','const2.length2','const3.length2','const4.length2'])
prob.model.connect('indeps.length4', ['ctr.length4','const3.length4'])
"""prob.model.connect('indeps.kappa1', ['ctr.kappa1','const1.kappa1','const2.kappa1'])"""
prob.model.connect('indeps.kappa2', ['ctr.kappa2','const1.kappa2','const2.kappa2','const3.kappa2'])
"""prob.model.connect('indeps.kappa3', ['ctr.kappa3','const1.kappa3','const2.kappa3'])"""
#prob.model.connect('indeps.E*pi*(d2**4-d1**4)/64', ['ctr.E*pi*(d2**4-d1**4)/64','const1.E*pi*(d2**4-d1**4)/64','const2.E*pi*(d2**4-d1**4)/64','const3.E*pi*(d2**4-d1**4)/64','const6.E*pi*(d2**4-d1**4)/64'])
#prob.model.connect('indeps.E*pi*(d4**4-d3**4)/64', ['ctr.E*pi*(d4**4-d3**4)/64','const1.E*pi*(d4**4-d3**4)/64','const2.E*pi*(d4**4-d3**4)/64','const3.E*pi*(d4**4-d3**4)/64','const5.E*pi*(d4**4-d3**4)/64','const6.E*pi*(d4**4-d3**4)/64'])
#prob.model.connect('indeps.E*pi*(d6**4-d5**4)/64', ['ctr.E*pi*(d6**4-d5**4)/64','const1.E*pi*(d6**4-d5**4)/64','const2.E*pi*(d6**4-d5**4)/64','const3.E*pi*(d6**4-d5**4)/64','const5.E*pi*(d6**4-d5**4)/64'])
prob.model.connect('indeps.psi2', ['ctr.psi2','const1.psi2','const2.psi2'])
prob.model.connect('indeps.d1', ['ctr.d1','const1.d1','const2.d1','const3.d1','const5.d1','const10.d1'])
prob.model.connect('indeps.d2', ['ctr.d2','const1.d2','const2.d2','const3.d2','const5.d2','const8.d2','const10.d2'])
prob.model.connect('indeps.d3', ['ctr.d3','const1.d3','const2.d3','const3.d3','const6.d3','const8.d3','const11.d3'])
prob.model.connect('indeps.d4', ['ctr.d4','const1.d4','const2.d4','const3.d4','const6.d4','const9.d4','const11.d4'])
prob.model.connect('indeps.d5', ['ctr.d5','const1.d5','const2.d5','const3.d5','const7.d5','const9.d5','const12.d5'])
prob.model.connect('indeps.d6', ['ctr.d6','const1.d6','const2.d6','const3.d6','const7.d6','const12.d6'])



# setup the optimization
prob.driver = om.ScipyOptimizeDriver()
prob.driver.options['maxiter'] = 600
prob.driver.options['optimizer'] = 'BFGS'


prob.model.add_design_var('indeps.length1', lower=-120, upper=0)
prob.model.add_design_var('indeps.length2', lower=-120, upper=0)
prob.model.add_design_var('indeps.length4', lower=-120, upper=0)
"""prob.model.add_design_var('indeps.kappa1', lower=0, upper=10)"""
prob.model.add_design_var('indeps.kappa2', lower=0, upper=.5)
"""prob.model.add_design_var('indeps.kappa3', lower=0, upper=10)"""
#prob.model.add_design_var('indeps.E*pi*(d2**4-d1**4)/64', lower=0, upper=25)
#prob.model.add_design_var('indeps.E*pi*(d4**4-d3**4)/64', lower=0, upper=25)
#prob.model.add_design_var('indeps.E*pi*(d6**4-d5**4)/64', lower=5, upper=70)
prob.model.add_design_var('indeps.l22', lower=-120, upper=0)
prob.model.add_design_var('indeps.psi2', lower=-2, upper=2)
prob.model.add_design_var('indeps.d1', lower=0.5, upper=1.5)
prob.model.add_design_var('indeps.d2', lower=1.5, upper=5)
prob.model.add_design_var('indeps.d3', lower=1.5, upper=5)
prob.model.add_design_var('indeps.d4', lower=1.5, upper=5)
prob.model.add_design_var('indeps.d5', lower=1.5, upper=5)
prob.model.add_design_var('indeps.d6', lower=1.5, upper=5)

prob.model.add_objective('ctr.f')


prob.model.add_constraint('const1.x', equals=data_pa[0])
prob.model.add_constraint('const2.y', equals=data_pa[1])
prob.model.add_constraint('const3.z', equals=data_pa[2])
prob.model.add_constraint('const4.g', upper=-1)
prob.model.add_constraint('const5.t1', lower=0)
prob.model.add_constraint('const6.t2', lower=0)
prob.model.add_constraint('const7.t3', lower=0)
prob.model.add_constraint('const8.t12', lower=0)
prob.model.add_constraint('const9.t23', lower=0)
prob.model.add_constraint('const10.k1', lower=4,upper=29)
prob.model.add_constraint('const11.k2', lower=30,upper=59)
prob.model.add_constraint('const12.k3', lower=60)

#prob.model.add_constraint('const5.k', lower=0)
#prob.model.add_constraint('const6.k2', lower=0)
#prob.model.add_constraint('const7.l23', lower=0)
prob.setup()
prob.run_driver()

# minimum value
#print(prob['parab.f_xy'])
t1=time.time()
# location of the minimum
print('time:', t1-t0)
print('Length1 =',prob['indeps.length1'])
print('Length3 =',prob['indeps.l22']-prob['indeps.length2'])
print('Length2 =',prob['indeps.length2'])
print('Length4 =',prob['indeps.length4'])
print('kappa2 = ',prob['indeps.kappa2'])
print('d1 = ',prob['indeps.d1'])
print('d2 = ',prob['indeps.d2'])
print('d3 = ',prob['indeps.d3'])
print('d4 = ',prob['indeps.d4'])
print('d5 = ',prob['indeps.d5'])
print('d6 = ',prob['indeps.d6'])
print('kb1 = ',E*np.pi*(prob['indeps.d2']**4-prob['indeps.d1']**4)/64)
print('kb2 = ',E*np.pi*(prob['indeps.d4']**4-prob['indeps.d3']**4)/64)
print('kb3 = ',E*np.pi*(prob['indeps.d2']**4-prob['indeps.d1']**4)/64)
print('l22 = ',prob['indeps.l22'])
print('psi2 = ',prob['indeps.psi2'])

