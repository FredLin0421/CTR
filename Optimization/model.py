# -*- coding: utf-8 -*-
"""
Spyder Editor

This is a temporary script file.
"""



import openmdao.api as om
import numpy as np
from math import cos, sin, sqrt


class CTR(om.ExplicitComponent):
    
    def setup(self):
        
        self.add_input('length1', val=np.zeros(95))
        self.add_input('length2', val=np.zeros(95))
        self.add_input('length4', val=np.zeros(95))
        self.add_input('kappa2', val=0.0)
        self.add_input('d1', val=0.0)
        self.add_input('d2', val=0.0)
        self.add_input('d3', val=0.0)
        self.add_input('d4', val=0.0)
        self.add_input('d5', val=0.0)
        self.add_input('d6', val=0.0)
        
        """self.add_input('E*np.pi*(d2**4-d1**4)/64', val=0.0)
        self.add_input('E*np.pi*(d4**4-d3**4)/64', val=0.0)
        self.add_input('E*np.pi*(d6**4-d5**4)/64', val=0.0)"""
        self.add_input('l22', val=np.zeros(95))
        self.add_input('psi2',val=np.zeros(95))
        self.add_output('f', val=0.0)
        

        # Finite difference all partials.
        self.declare_partials('*', '*', method='fd')

    def compute(self, inputs, outputs):
    
        length1 = inputs['length1']
        length2 = inputs['length2']
        length4 = inputs['length4']
        kappa2 = inputs['kappa2']
        d1 = inputs['d1']
        d2 = inputs['d2']
        d3 = inputs['d3']
        d4 = inputs['d4']
        d5 = inputs['d5']
        d6 = inputs['d6']

        """E*np.pi*(d2**4-d1**4)/64 = inputs['E*np.pi*(d2**4-d1**4)/64']
        E*np.pi*(d4**4-d3**4)/64 = inputs['E*np.pi*(d4**4-d3**4)/64']
        E*np.pi*(d6**4-d5**4)/64 = inputs['E*np.pi*(d6**4-d5**4)/64']"""
        l22 = inputs['l22']
        psi2 = inputs['psi2']
        
        # Derive the backbone points
        def backbone(inputs):
            E = 80
            backbone_point = [[np.zeros(len(length4)),np.zeros(len(length4)),length4],
                              [ -(np.cos(psi2)*(np.cos(((kappa2*E*np.pi*(d4**4-d3**4)/64)*((l22 - length2)/2))/(E*np.pi*(d2**4-d1**4)/64 + E*np.pi*(d4**4-d3**4)/64 + E*np.pi*(d6**4-d5**4)/64)) - 1)*(E*np.pi*(d2**4-d1**4)/64 + E*np.pi*(d4**4-d3**4)/64 + E*np.pi*(d6**4-d5**4)/64))/(kappa2*E*np.pi*(d4**4-d3**4)/64), -(np.sin(psi2)*(np.cos(((kappa2*E*np.pi*(d4**4-d3**4)/64)*((l22 - length2)/2))/(E*np.pi*(d2**4-d1**4)/64 + E*np.pi*(d4**4-d3**4)/64 + E*np.pi*(d6**4-d5**4)/64)) - 1)*(E*np.pi*(d2**4-d1**4)/64 + E*np.pi*(d4**4-d3**4)/64 + E*np.pi*(d6**4-d5**4)/64))/(kappa2*E*np.pi*(d4**4-d3**4)/64), length4 + (np.sin(((kappa2*E*np.pi*(d4**4-d3**4)/64)*((l22 - length2)/2))/(E*np.pi*(d2**4-d1**4)/64 + E*np.pi*(d4**4-d3**4)/64 + E*np.pi*(d6**4-d5**4)/64))*(E*np.pi*(d2**4-d1**4)/64 + E*np.pi*(d4**4-d3**4)/64 + E*np.pi*(d6**4-d5**4)/64))/(kappa2*E*np.pi*(d4**4-d3**4)/64)],
                              [ -(np.cos(psi2)*(np.cos(((kappa2*E*np.pi*(d4**4-d3**4)/64)*(l22 - length2))/(E*np.pi*(d2**4-d1**4)/64 + E*np.pi*(d4**4-d3**4)/64 + E*np.pi*(d6**4-d5**4)/64)) - 1)*(E*np.pi*(d2**4-d1**4)/64 + E*np.pi*(d4**4-d3**4)/64 + E*np.pi*(d6**4-d5**4)/64))/(kappa2*E*np.pi*(d4**4-d3**4)/64), -(np.sin(psi2)*(np.cos(((kappa2*E*np.pi*(d4**4-d3**4)/64)*(l22 - length2))/(E*np.pi*(d2**4-d1**4)/64 + E*np.pi*(d4**4-d3**4)/64 + E*np.pi*(d6**4-d5**4)/64)) - 1)*(E*np.pi*(d2**4-d1**4)/64 + E*np.pi*(d4**4-d3**4)/64 + E*np.pi*(d6**4-d5**4)/64))/(kappa2*E*np.pi*(d4**4-d3**4)/64), length4 + (np.sin(((kappa2*E*np.pi*(d4**4-d3**4)/64)*(l22 - length2))/(E*np.pi*(d2**4-d1**4)/64 + E*np.pi*(d4**4-d3**4)/64 + E*np.pi*(d6**4-d5**4)/64))*(E*np.pi*(d2**4-d1**4)/64 + E*np.pi*(d4**4-d3**4)/64 + E*np.pi*(d6**4-d5**4)/64))/(kappa2*E*np.pi*(d4**4-d3**4)/64)],
                              [ (np.sin(((kappa2*E*np.pi*(d4**4-d3**4)/64)*(l22 - length2/2))/(E*np.pi*(d2**4-d1**4)/64 + E*np.pi*(d4**4-d3**4)/64 + E*np.pi*(d6**4-d5**4)/64))*np.cos(psi2)*np.sin(((kappa2*E*np.pi*(d4**4-d3**4)/64)*(length2/2))/(E*np.pi*(d2**4-d1**4)/64 + E*np.pi*(d4**4-d3**4)/64))*(E*np.pi*(d2**4-d1**4)/64 + E*np.pi*(d4**4-d3**4)/64))/(kappa2*E*np.pi*(d4**4-d3**4)/64) - (np.cos(((kappa2*E*np.pi*(d4**4-d3**4)/64)*(l22 - length2/2))/(E*np.pi*(d2**4-d1**4)/64 + E*np.pi*(d4**4-d3**4)/64 + E*np.pi*(d6**4-d5**4)/64))*np.cos(psi2)*(np.cos(((kappa2*E*np.pi*(d4**4-d3**4)/64)*(length2/2))/(E*np.pi*(d2**4-d1**4)/64 + E*np.pi*(d4**4-d3**4)/64)) - 1)*(E*np.pi*(d2**4-d1**4)/64 + E*np.pi*(d4**4-d3**4)/64))/(kappa2*E*np.pi*(d4**4-d3**4)/64) - (np.cos(psi2)*(np.cos(((kappa2*E*np.pi*(d4**4-d3**4)/64)*(l22 - length2/2))/(E*np.pi*(d2**4-d1**4)/64 + E*np.pi*(d4**4-d3**4)/64 + E*np.pi*(d6**4-d5**4)/64)) - 1)*(E*np.pi*(d2**4-d1**4)/64 + E*np.pi*(d4**4-d3**4)/64 + E*np.pi*(d6**4-d5**4)/64))/(kappa2*E*np.pi*(d4**4-d3**4)/64), (np.sin(((kappa2*E*np.pi*(d4**4-d3**4)/64)*(l22 - length2/2))/(E*np.pi*(d2**4-d1**4)/64 + E*np.pi*(d4**4-d3**4)/64 + E*np.pi*(d6**4-d5**4)/64))*np.sin(((kappa2*E*np.pi*(d4**4-d3**4)/64)*(length2/2))/(E*np.pi*(d2**4-d1**4)/64 + E*np.pi*(d4**4-d3**4)/64))*np.sin(psi2)*(E*np.pi*(d2**4-d1**4)/64 + E*np.pi*(d4**4-d3**4)/64))/(kappa2*E*np.pi*(d4**4-d3**4)/64) - (np.cos(((kappa2*E*np.pi*(d4**4-d3**4)/64)*(l22 - length2/2))/(E*np.pi*(d2**4-d1**4)/64 + E*np.pi*(d4**4-d3**4)/64 + E*np.pi*(d6**4-d5**4)/64))*np.sin(psi2)*(np.cos(((kappa2*E*np.pi*(d4**4-d3**4)/64)*(length2/2))/(E*np.pi*(d2**4-d1**4)/64 + E*np.pi*(d4**4-d3**4)/64)) - 1)*(E*np.pi*(d2**4-d1**4)/64 + E*np.pi*(d4**4-d3**4)/64))/(kappa2*E*np.pi*(d4**4-d3**4)/64) - (np.sin(psi2)*(np.cos((kappa2*E*np.pi*(d4**4-d3**4)/64*(l22 - length2/2))/(E*np.pi*(d2**4-d1**4)/64 + E*np.pi*(d4**4-d3**4)/64 + E*np.pi*(d6**4-d5**4)/64)) - 1)*(E*np.pi*(d2**4-d1**4)/64 + E*np.pi*(d4**4-d3**4)/64 + E*np.pi*(d6**4-d5**4)/64))/(kappa2*E*np.pi*(d4**4-d3**4)/64), length4 + (np.sin(((kappa2*E*np.pi*(d4**4-d3**4)/64)*(l22 - length2/2))/(E*np.pi*(d2**4-d1**4)/64 + E*np.pi*(d4**4-d3**4)/64 + E*np.pi*(d6**4-d5**4)/64))*(E*np.pi*(d2**4-d1**4)/64 + E*np.pi*(d4**4-d3**4)/64 + E*np.pi*(d6**4-d5**4)/64))/(kappa2*E*np.pi*(d4**4-d3**4)/64) + (np.cos(((kappa2*E*np.pi*(d4**4-d3**4)/64)*(l22 - length2/2))/(E*np.pi*(d2**4-d1**4)/64 + E*np.pi*(d4**4-d3**4)/64 + E*np.pi*(d6**4-d5**4)/64))*np.sin((kappa2*E*np.pi*(d4**4-d3**4)/64*(length2/2))/(E*np.pi*(d2**4-d1**4)/64 + E*np.pi*(d4**4-d3**4)/64))*(E*np.pi*(d2**4-d1**4)/64 + E*np.pi*(d4**4-d3**4)/64))/(kappa2*E*np.pi*(d4**4-d3**4)/64) + (np.sin(((kappa2*E*np.pi*(d4**4-d3**4)/64)*(l22 - length2/2))/(E*np.pi*(d2**4-d1**4)/64 + E*np.pi*(d4**4-d3**4)/64 + E*np.pi*(d6**4-d5**4)/64))*(np.cos(((kappa2*E*np.pi*(d4**4-d3**4)/64)*(length2/2))/(E*np.pi*(d2**4-d1**4)/64 + E*np.pi*(d4**4-d3**4)/64)) - 1)*(E*np.pi*(d2**4-d1**4)/64 + E*np.pi*(d4**4-d3**4)/64))/(kappa2*E*np.pi*(d4**4-d3**4)/64)],
                              [ (np.sin(((kappa2*E*np.pi*(d4**4-d3**4)/64)*(l22 - length2))/(E*np.pi*(d2**4-d1**4)/64 + E*np.pi*(d4**4-d3**4)/64 + E*np.pi*(d6**4-d5**4)/64))*np.cos(psi2)*np.sin(((kappa2*E*np.pi*(d4**4-d3**4)/64)*(length2))/(E*np.pi*(d2**4-d1**4)/64 + E*np.pi*(d4**4-d3**4)/64))*(E*np.pi*(d2**4-d1**4)/64 + E*np.pi*(d4**4-d3**4)/64))/(kappa2*E*np.pi*(d4**4-d3**4)/64) - (np.cos(((kappa2*E*np.pi*(d4**4-d3**4)/64)*(l22 - length2))/(E*np.pi*(d2**4-d1**4)/64 + E*np.pi*(d4**4-d3**4)/64 + E*np.pi*(d6**4-d5**4)/64))*np.cos(psi2)*(np.cos(((kappa2*E*np.pi*(d4**4-d3**4)/64)*(length2))/(E*np.pi*(d2**4-d1**4)/64 + E*np.pi*(d4**4-d3**4)/64)) - 1)*(E*np.pi*(d2**4-d1**4)/64 + E*np.pi*(d4**4-d3**4)/64))/(kappa2*E*np.pi*(d4**4-d3**4)/64) - (np.cos(psi2)*(np.cos(((kappa2*E*np.pi*(d4**4-d3**4)/64)*(l22 - length2))/(E*np.pi*(d2**4-d1**4)/64 + E*np.pi*(d4**4-d3**4)/64 + E*np.pi*(d6**4-d5**4)/64)) - 1)*(E*np.pi*(d2**4-d1**4)/64 + E*np.pi*(d4**4-d3**4)/64 + E*np.pi*(d6**4-d5**4)/64))/(kappa2*E*np.pi*(d4**4-d3**4)/64), (np.sin(((kappa2*E*np.pi*(d4**4-d3**4)/64)*(l22 - length2))/(E*np.pi*(d2**4-d1**4)/64 + E*np.pi*(d4**4-d3**4)/64 + E*np.pi*(d6**4-d5**4)/64))*np.sin(((kappa2*E*np.pi*(d4**4-d3**4)/64)*(length2))/(E*np.pi*(d2**4-d1**4)/64 + E*np.pi*(d4**4-d3**4)/64))*np.sin(psi2)*(E*np.pi*(d2**4-d1**4)/64 + E*np.pi*(d4**4-d3**4)/64))/(kappa2*E*np.pi*(d4**4-d3**4)/64) - (np.cos(((kappa2*E*np.pi*(d4**4-d3**4)/64)*(l22 - length2))/(E*np.pi*(d2**4-d1**4)/64 + E*np.pi*(d4**4-d3**4)/64 + E*np.pi*(d6**4-d5**4)/64))*np.sin(psi2)*(np.cos(((kappa2*E*np.pi*(d4**4-d3**4)/64)*(length2))/(E*np.pi*(d2**4-d1**4)/64 + E*np.pi*(d4**4-d3**4)/64)) - 1)*(E*np.pi*(d2**4-d1**4)/64 + E*np.pi*(d4**4-d3**4)/64))/(kappa2*E*np.pi*(d4**4-d3**4)/64) - (np.sin(psi2)*(np.cos(((kappa2*E*np.pi*(d4**4-d3**4)/64)*(l22 - length2))/(E*np.pi*(d2**4-d1**4)/64 + E*np.pi*(d4**4-d3**4)/64 + E*np.pi*(d6**4-d5**4)/64)) - 1)*(E*np.pi*(d2**4-d1**4)/64 + E*np.pi*(d4**4-d3**4)/64 + E*np.pi*(d6**4-d5**4)/64))/(kappa2*E*np.pi*(d4**4-d3**4)/64), length4 + (np.sin(((kappa2*E*np.pi*(d4**4-d3**4)/64)*(l22 - length2))/(E*np.pi*(d2**4-d1**4)/64 + E*np.pi*(d4**4-d3**4)/64 + E*np.pi*(d6**4-d5**4)/64))*(E*np.pi*(d2**4-d1**4)/64 + E*np.pi*(d4**4-d3**4)/64 + E*np.pi*(d6**4-d5**4)/64))/(kappa2*E*np.pi*(d4**4-d3**4)/64) + (np.cos(((kappa2*E*np.pi*(d4**4-d3**4)/64)*(l22 - length2))/(E*np.pi*(d2**4-d1**4)/64 + E*np.pi*(d4**4-d3**4)/64 + E*np.pi*(d6**4-d5**4)/64))*np.sin((kappa2*E*np.pi*(d4**4-d3**4)/64*(length2))/(E*np.pi*(d2**4-d1**4)/64 + E*np.pi*(d4**4-d3**4)/64))*(E*np.pi*(d2**4-d1**4)/64 + E*np.pi*(d4**4-d3**4)/64))/(kappa2*E*np.pi*(d4**4-d3**4)/64) + (np.sin(((kappa2*E*np.pi*(d4**4-d3**4)/64)*(l22 - length2))/(E*np.pi*(d2**4-d1**4)/64 + E*np.pi*(d4**4-d3**4)/64 + E*np.pi*(d6**4-d5**4)/64))*(np.cos(((kappa2*E*np.pi*(d4**4-d3**4)/64)*(length2))/(E*np.pi*(d2**4-d1**4)/64 + E*np.pi*(d4**4-d3**4)/64)) - 1)*(E*np.pi*(d2**4-d1**4)/64 + E*np.pi*(d4**4-d3**4)/64))/(kappa2*E*np.pi*(d4**4-d3**4)/64)],
                              [np.zeros(len(length4)),np.zeros(len(length4)),length1/2]]
            return backbone_point
        
        def vec_distant(x,y,z):
            x = np.concatenate((x), axis=None)
            y = np.concatenate((y), axis=None)
            z = np.concatenate((z), axis=None)
            X = np.subtract(x[:98],x[1:99])
            Y = np.subtract(y[:98],y[1:99])
            Z = np.subtract(z[:98],z[1:99])
            dist = np.sum(np.sqrt((np.square(X)+np.square(Y)+np.square(Z))))
            return dist
        
        """def vec_surface(x,y,z):
            x = np.array(x)
            y = np.array(y)
            z = np.array(z)
            X = x[:][np.newaxis,:] - x[:][:, np.newaxis]
            Y = y[:][np.newaxis,:] - y[:][:, np.newaxis]
            Z = z[:][np.newaxis,:] - z[:][:, np.newaxis]
            dist = np.sum(np.sqrt((np.square(X.flatten())+np.square(Y.flatten())+np.square(Z.flatten()))))
            return dist"""
        
        backbone_point = np.array(backbone(inputs))
        x = [backbone_point[0][0],backbone_point[1][0],backbone_point[2][0],backbone_point[3][0],backbone_point[4][0],backbone_point[5][0]]
        y = [backbone_point[0][1],backbone_point[1][1],backbone_point[2][1],backbone_point[3][1],backbone_point[4][1],backbone_point[5][1]]
        z = [backbone_point[0][2],backbone_point[1][2],backbone_point[2][2],backbone_point[3][2],backbone_point[4][2],backbone_point[5][2]]
        
        # Objective function 1
        outputs['f'] = vec_distant(x,y,z)
        # Objective function 2
        """outputs['f'] = vec_surface(x,y,z)"""
        # Objective function 3
        """backbone_point = np.array(backbone(inputs))
        outputs['f_xy'] = np.linalg.norm(backbone_point)"""
        
        

if __name__ == "__main__":
    N = 95
    model = om.Group()
    ivc = om.IndepVarComp()
    ivc.add_output('length1', np.ones(N))
    ivc.add_output('length2', np.ones(N))
    ivc.add_output('length4', np.ones(N))
    ivc.add_output('kappa2', 1.0)
    ivc.add_output('d1', 1.0)
    ivc.add_output('d2', 3.0)
    ivc.add_output('d3', 1.0)
    ivc.add_output('d4', 3.0)
    ivc.add_output('d5', 1.0)
    ivc.add_output('d6', 3.0)
    ivc.add_output('l22', np.ones(N))
    ivc.add_output('psi2', np.ones(N))
    model.add_subsystem('des_vars', ivc)
    model.add_subsystem('parab_comp', CTR())

    model.connect('des_vars.length1', 'parab_comp.length1')
    model.connect('des_vars.length2', 'parab_comp.length2')
    """model.connect('des_vars.kappa1', 'parab_comp.kappa1')"""
    model.connect('des_vars.kappa2', 'parab_comp.kappa2')
    """ model.connect('des_vars.kappa3', 'parab_comp.kappa3')"""
    #model.connect('des_vars.E*np.pi*(d2**4-d1**4)/64', 'parab_comp.E*np.pi*(d2**4-d1**4)/64')
    #model.connect('des_vars.E*np.pi*(d4**4-d3**4)/64', 'parab_comp.E*np.pi*(d4**4-d3**4)/64')
    #model.connect('des_vars.E*np.pi*(d6**4-d5**4)/64', 'parab_comp.E*np.pi*(d6**4-d5**4)/64')
    model.connect('des_vars.l22', 'parab_comp.l22')
    model.connect('des_vars.psi2', 'parab_comp.psi2')
    model.connect('des_vars.d1', 'parab_comp.d1')
    model.connect('des_vars.d2', 'parab_comp.d2')
    model.connect('des_vars.d3', 'parab_comp.d3')
    model.connect('des_vars.d4', 'parab_comp.d4')
    model.connect('des_vars.d5', 'parab_comp.d5')
    model.connect('des_vars.d6', 'parab_comp.d6')
 

    prob = om.Problem(model)
    prob.setup()
    prob.run_model()
    print((prob['parab_comp.length1']))
    print(prob['parab_comp.f'])

    """prob['des_vars.x'] = 5.0
    prob['des_vars.y'] = -2.0
    prob.run_model()
    print(prob['parab_comp.f_xy'])"""
   