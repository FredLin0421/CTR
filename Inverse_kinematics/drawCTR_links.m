clc;
clear all;
load('path.mat')
load('D:\Desktop\Fred\CTR\CTR optimization\CTR\Inverse_kinematics\jointvalues\jointvalue_alldistance01.mat')

%% tube definition from outer to inner
% link_nbr = 4;
% % command (stroke(mm), angle(rad))
% diam = [2.184; 2.184; 1.524; 1.2];  % outer 
%% vectorization result without fix stiffness
Length1 = [-54.61104484 -53.3927999  -52.45094913 -51.8134735  -33.1949327...
 -33.0726364  -33.17977544 -33.21434978 -33.76581764 -34.89722439...
 -35.16143767 -36.27006879 -37.79833445 -37.35620756 -40.46970545...
 -40.55730067 -40.96642304 -40.42735432 -37.39002358 -37.79307611...
 -36.2679156  -35.15551403 -34.88481632 -33.75369891 -33.19987488...
 -33.15700216 -33.04693076 -33.12641514 -33.2495671  -33.64310425...
 -34.73788368 -38.94504494 -38.58324473 -34.74817329 -33.65149726...
 -33.32800748 -33.21090085 -33.27833715 -33.50743826 -33.89847407...
 -32.99079937 -32.09327199 -31.22050183 -30.38759577 -29.52965974...
 -28.69890117 -27.63713751 -26.84633858 -26.14666186 -24.14604398...
 -24.77201894 -26.56850797 -29.33023632 -32.31078552 -35.61418891...
 -37.50346337 -38.30380842 -39.71747611 -38.62783961 -35.68572223...
 -33.49512851 -31.76767142 -28.03740505 -28.48552705 -26.70947802...
 -27.87378718 -28.30770653 -29.6954214  -31.05641859 -31.83305162...
 -34.4533408  -33.4571852  -33.65359961 -33.59299236 -31.88564872...
 -33.22590059 -32.99282907 -33.21484386 -33.96704782 -34.5683734...
 -35.11702515 -35.88447927 -36.1384796  -35.3719917  -37.66944591...
 -35.63586777 -36.64002842 -36.69540757 -36.4905707  -36.4764119...
 -36.60714482 -36.6715137  -36.88823222 -38.21206969 -37.54595017];
Length3 = [ -1.          -1.00000515  -1.00000351  -1.         -26.76709351...
 -27.04882667 -27.54303089 -28.63134692 -29.47738873 -29.93916345...
 -31.90672428 -32.99833448 -33.71347339 -37.26990674 -36.01546545...
 -38.9812935  -38.41016046 -36.07057971 -37.21786424 -33.7061684...
 -32.98038211 -31.88507174 -29.91537504 -29.44996277 -28.59251576...
 -27.50525947 -27.00129876 -26.7682641  -27.01775614 -27.43423491...
 -27.35675432 -23.14002448 -23.66108127 -27.32634926 -27.40039823...
 -26.87335051 -26.6086542  -26.64030423 -26.97331024 -27.59138875...
 -26.37059283 -25.17982248 -24.00057123 -22.82633389 -21.66127092...
 -20.58170383 -19.87822598 -18.86065962 -17.77708274 -18.64999555...
 -17.78392088 -20.57885905 -23.47633624 -26.2501458  -27.81108697...
 -29.77388756 -31.19841113 -29.41395622 -28.85649085 -29.20091301...
 -27.45940525 -24.77979287 -25.19535628 -21.1160719  -21.73262219...
 -20.23634098 -21.39075708 -22.30840276 -23.64271788 -25.54564314...
 -24.28779566 -26.96783835 -27.03157292 -26.54086027 -27.63603522...
 -26.66759326 -27.81120292 -28.35106285 -28.18117635 -28.21921548...
 -28.33328576 -28.15365406 -28.67602188 -30.61018137 -28.33225417...
 -31.25193049 -30.19048032 -30.62410343 -31.60221069 -32.5127402...
 -33.41272548 -34.59000181 -35.73800656 -35.5093567  -38.24532877];
Length2 = [ -6.73670027  -7.28885064  -7.87469763  -8.47820045  -3.18504543...
  -3.96419844  -4.6127479   -5.02572294  -5.37504426  -5.6765548...
  -5.52112458  -5.4248127   -5.29474645  -4.3776361   -4.52356987...
  -3.5261174   -3.67695844  -4.51092157  -4.39212062  -5.30090726...
  -5.43540876  -5.5352135   -5.69400982  -5.39409787  -5.05107189...
  -4.63980155  -3.99623517  -3.20588933  -2.23228299  -1.17875351...
  -0.28480732  -0.77643723  -0.61501457  -0.29687359  -1.19285022...
  -2.27946634  -3.25687575  -4.09479385  -4.77690225  -5.28826637...
  -6.30524001  -7.3312619   -8.37059277  -9.4195399  -10.51008612...
 -11.58044865 -12.64666992 -13.75659106 -14.88311374 -16.09173138...
 -16.30512742 -14.10560158 -11.24707873  -8.26668465  -5.77573208...
  -3.74224479  -2.51151769  -2.92974271  -3.71745809  -4.83492607...
  -6.80402458  -8.97225979 -10.56054969 -12.08329795 -12.60440039...
 -12.52071245 -11.71527395 -10.54670132  -9.20694284  -7.8432766...
  -7.26695959  -6.29166947  -6.16193128  -6.45311063  -6.65646302...
  -6.55394791  -6.05014389  -5.66304262  -5.43055184  -5.16144804...
  -4.8817657   -4.67718221  -4.31254832  -3.59137094  -3.93746018...
  -4.06876413  -5.16882551  -5.88261047  -6.45871536  -7.02740791...
  -7.57157429  -8.03386347  -8.47018284  -9.1067981   -9.19821488];
Length4 = [-41.15445126 -41.15445076 -41.15445086 -41.15445131 -41.15557425...
 -41.15860672 -41.16350078 -41.16977931 -41.17433758 -41.17584191...
 -41.18020249 -41.18086395 -41.18106461 -41.18612674 -41.1861583...
 -41.18779781 -41.18823783 -41.18937892 -41.19100537 -41.19383421...
 -41.1989185  -41.20531554 -41.20935091 -41.20942017 -41.21511613...
 -41.21518566 -41.21881432 -41.22132271 -41.2251678  -41.22928679...
 -41.23258586 -41.23650267 -41.2394797  -41.24236468 -41.24362229...
 -41.24883201 -41.25197141 -41.25231198 -41.25840446 -41.25936464...
 -41.2621921  -41.26840545 -41.27728999 -41.27779447 -41.3410364...
 -41.3445848  -41.3445917  -41.34811365 -41.35161894 -41.35253694...
 -41.39285548 -41.39865943 -41.41280536 -41.4135389  -41.41438279...
 -41.42659729 -41.43241559 -41.43761391 -41.50360195 -41.51327784...
 -41.51562926 -41.51722524 -41.52695249 -41.53397919 -41.53985726...
 -41.54319055 -41.54570469 -41.55172529 -41.56148205 -41.56580542...
 -41.57332208 -41.58004603 -41.58008159 -41.58431693 -41.58713732...
 -41.58715408 -41.59123693 -41.5949694  -41.59926086 -41.60312126...
 -41.60672608 -41.60950843 -41.61565203 -41.62196169 -41.62477389...
 -41.62681056 -41.62727306 -41.62766709 -41.62998288 -41.63005375...
 -41.63052609 -41.63063424 -41.63192995 -41.6334894  -41.63354855];
kappa2 =  [0.09528177];
kb1 =  [0.12072151];
kb2 =  [0.27558831];
kb3 =  [0.8302754];
l22 =  [ -7.73670027  -8.28885579  -8.87470114  -9.47820045 -29.95213894...
 -31.01302511 -32.15577879 -33.65706986 -34.85243298 -35.61571825...
 -37.42784886 -38.42314718 -39.00821985 -41.64754283 -40.53903532...
 -42.5074109  -42.0871189  -40.58150129 -41.60998486 -39.00707567...
 -38.41579087 -37.42028525 -35.60938486 -34.84406064 -33.64358764...
 -32.14506103 -30.99753393 -29.97415344 -29.25003913 -28.61298842...
 -27.64156164 -23.91646171 -24.27609584 -27.62322285 -28.59324845...
 -29.15281685 -29.86552995 -30.73509808 -31.75021248 -32.87965512...
 -32.67583284 -32.51108439 -32.37116399 -32.24587379 -32.17135704...
 -32.16215247 -32.52489591 -32.61725068 -32.66019648 -34.74172693...
 -34.0890483  -34.68446064 -34.72341498 -34.51683045 -33.58681904...
 -33.51613234 -33.70992881 -32.34369893 -32.57394894 -34.03583908...
 -34.26342984 -33.75205266 -35.75590597 -33.19936985 -34.33702258...
 -32.75705342 -33.10603103 -32.85510408 -32.84966072 -33.38891974...
 -31.55475525 -33.25950782 -33.19350421 -32.99397089 -34.29249824...
 -33.22154117 -33.86134681 -34.01410547 -33.61172819 -33.38066352...
 -33.21505146 -32.83083628 -32.9885702  -34.20155231 -32.26971435...
 -35.32069462 -35.35930584 -36.5067139  -38.06092605 -39.54014811...
 -40.98429977 -42.62386529 -44.20818939 -44.61615481 -47.44354365];
psi2 =  [ 4.04359241e-22 -8.90734033e-24 -6.61937048e-23  7.67913351e-22...
  1.83878983e-21  7.62298857e-21  1.05320542e-21  2.05511930e-21...
 -1.73759241e-21 -7.28621463e-21  4.83163214e-21 -7.24816980e-21...
  6.84594210e-21 -8.77794889e-21 -2.29194266e-20  8.02961815e-21...
  5.92834274e-21  8.34468768e-21 -2.49224686e-21 -8.74232780e-21...
 -1.11312908e-20  3.16740022e-21  3.24184902e-21  1.11082207e-22...
 -6.42404192e-21 -6.84129034e-21 -3.81233433e-22  5.35685375e-22...
  2.79602584e-21  8.06653460e-21 -7.04694012e-21  2.83091667e-22...
 -2.50134037e-21 -9.14098114e-22 -1.02547569e-20  9.48673873e-21...
  9.32447946e-21  2.18398762e-21  5.83052083e-21 -6.99949844e-21...
  1.57329178e-03  3.13820137e-03  4.69478797e-03  6.24311031e-03...
  7.78322668e-03  9.31519489e-03  1.08390723e-02  1.23549158e-02...
  1.38627819e-02  1.53627265e-02 -1.27356484e-01 -2.45782889e-01...
 -3.11704471e-01 -3.22639183e-01 -2.81660777e-01 -1.95883577e-01...
 -7.90756270e-02  4.72260173e-02  1.59165228e-01  2.39058598e-01...
  2.78788133e-01  2.77621979e-01  2.39550404e-01  1.72676453e-01...
  8.94784727e-02  5.44527296e-03 -6.46663146e-02 -1.10638007e-01...
 -1.28251297e-01 -1.18690964e-01 -8.74039149e-02 -4.29395509e-02...
  4.64666287e-03  4.59586081e-02  7.43001782e-02  7.68816616e-02...
  7.94685848e-02  8.20609301e-02  8.46586797e-02  8.72618154e-02...
  8.98703184e-02  9.24841699e-02  9.51033505e-02  9.77278403e-02...
  1.00357619e-01  9.54369425e-02  9.09749775e-02  8.69105936e-02...
  8.31930362e-02  7.97798188e-02  7.66351094e-02  7.37284784e-02...
  7.10339193e-02  6.85290747e-02  6.61946186e-02];
%% surface area single point
%time: 285.3248827457428
Length1 = [-52.91449515 -51.54068234 -50.43416485 -49.6280779  -36.59136409...
 -36.10012018 -35.8570654  -36.00769171 -36.22864119 -36.57111819...
 -34.67292277 -37.93100409 -38.92363049 -38.51010011 -40.28829497...
 -41.4306304  -41.78288596 -40.29348323 -38.85945152 -38.63682913...
 -37.93217631 -34.6513682  -36.56445404 -36.2282537  -36.02579962...
 -35.84388994 -36.10505743 -36.60243325 -37.27454879 -38.64044955...
 -40.28517019 -41.71595294 -42.03996443 -40.05766239 -38.63656064...
 -37.29688272 -36.71109299 -36.35021447 -36.16285903 -36.16127112...
 -34.9509099  -33.76206143 -32.61318569 -31.51744145 -30.42501297...
 -29.32420339 -28.20406992 -27.41284257 -26.1139117  -23.87422847...
 -26.23501682 -29.29561255 -32.05274098 -35.46061475 -37.86464889...
 -42.27019124 -41.74465236 -42.10505596 -39.23504185 -37.31720303...
 -34.82260036 -32.57014165 -30.05878778 -27.32112822 -28.2343489...
 -28.70536061 -29.87276461 -31.32576656 -33.02300878 -34.16433443...
 -35.01695905 -37.30901216 -35.85173845 -35.00693554 -32.63742725...
 -34.90577947 -35.49792381 -35.92980405 -36.1859126  -36.63561928...
 -37.02762064 -37.29719184 -37.72846458 -38.34522341 -40.32954681...
 -37.98047045 -37.6437927  -37.19166813 -36.75111103 -36.34415346...
 -36.27315052 -36.0793652  -35.71811695 -35.21389921 -30.47621015];
Length3 = [-2.81022289e-03 -2.90300904e-03 -2.89654154e-03 -2.89011049e-03...
 -2.10556167e+01 -2.16629464e+01 -2.24934235e+01 -2.32971075e+01...
 -2.45623870e+01 -2.61510214e+01 -3.18512771e+01 -2.95169757e+01...
 -3.11797775e+01 -3.54260437e+01 -3.61832891e+01 -3.81171962e+01...
 -3.75096756e+01 -3.61745380e+01 -3.48398330e+01 -3.16539205e+01...
 -2.95151710e+01 -3.18866694e+01 -2.61619651e+01 -2.45631286e+01...
 -2.32678278e+01 -2.25149271e+01 -2.16548944e+01 -2.10373204e+01...
 -2.07565361e+01 -1.99015151e+01 -1.91014600e+01 -1.91473324e+01...
 -1.85788691e+01 -1.94944510e+01 -1.99080613e+01 -2.07189020e+01...
 -2.08573525e+01 -2.12531244e+01 -2.19956276e+01 -2.30477855e+01...
 -2.17814445e+01 -2.05136917e+01 -1.92147155e+01 -1.78637095e+01...
 -1.65377754e+01 -1.52537654e+01 -1.40279449e+01 -1.23104528e+01...
 -1.14224813e+01 -1.20602292e+01 -8.13653353e+00 -1.04799736e+01...
 -1.52411650e+01 -1.90145547e+01 -2.32586254e+01 -2.21033174e+01...
 -2.63773415e+01 -2.60433650e+01 -2.82214398e+01 -2.63849572e+01...
 -2.40904392e+01 -2.09984753e+01 -1.88772826e+01 -1.85795256e+01...
 -1.48934491e+01 -1.43587561e+01 -1.48929057e+01 -1.63660898e+01...
 -1.79382590e+01 -2.00764435e+01 -2.17691796e+01 -1.98748193e+01...
 -2.26682296e+01 -2.32685568e+01 -2.54470538e+01 -2.29434572e+01...
 -2.31051146e+01 -2.35283922e+01 -2.42421040e+01 -2.46475508e+01...
 -2.51525257e+01 -2.58658918e+01 -2.63189544e+01 -2.64667586e+01...
 -2.43215003e+01 -2.79682253e+01 -2.84543592e+01 -2.93501735e+01...
 -3.04442626e+01 -3.17010587e+01 -3.26325484e+01 -3.39795228e+01...
 -3.58084504e+01 -3.80733576e+01 -4.72503308e+01];
Length2 = [ -9.01805796  -9.73941443 -10.50708604 -11.29995151  -4.81022948...
  -5.57612842  -6.18642921  -6.69973862  -6.9210782   -6.88385951...
  -5.20910551  -6.27200583  -5.74087336  -4.06796425  -3.59476462...
  -2.53600936  -2.78800762  -3.59825976  -4.29708382  -5.5649981...
  -6.27262402  -5.19603203  -6.88001183  -6.92079139  -6.70995269...
  -6.17874454  -5.57906843  -4.81714607  -3.88735982  -3.18726286...
  -2.51382914  -1.55746502  -1.80068698  -2.35008886  -3.18462478...
  -3.90216843  -4.88518354  -5.7258944   -6.36357704  -6.78686648...
  -8.09356847  -9.42577402 -10.79264355 -12.19796547 -13.62118765...
 -15.06203711 -16.5225631  -18.0849383  -19.56362348 -21.00054293...
 -21.591331   -18.8608224  -15.03626718 -11.17146877  -7.33460034...
  -5.98069208  -3.36754655  -3.41485931  -3.27603239  -5.4327203...
  -8.12577082 -11.10148052 -13.5203312  -15.02856781 -16.32655976...
 -16.22792215 -15.26763095 -13.69617011 -11.94571234 -10.1142326...
  -8.65319288  -8.73096399  -7.67697378  -7.70015637  -7.47401689...
  -7.95400174  -7.57890509  -7.12142329  -6.56520722  -6.11865125...
  -5.63917359  -5.08356859  -4.62661118  -4.29144498  -4.85551857...
  -4.48481367  -5.34151281  -6.03391302  -6.64231656  -7.17715449...
  -7.79892183  -8.25060236  -8.51295167  -8.60095339  -6.39295336];
Length4 = [-41.61432657 -41.6142791  -41.61428226 -41.61428502 -41.61428614...
 -41.61428887 -41.61428941 -41.61429311 -41.6143014  -41.61430217...
 -41.61430356 -41.61430489 -41.61430376 -41.61429899 -41.61429009...
 -41.61427667 -41.61427347 -41.61425419 -41.61425278 -41.61422944...
 -41.61422916 -41.61422443 -41.61422626 -41.61423223 -41.61424132...
 -41.61425214 -41.61426825 -41.61427269 -41.61427763 -41.61430596...
 -41.61431256 -41.61432468 -41.614337   -41.61433817 -41.61434476...
 -41.61435489 -41.61436844 -41.61441909 -41.61443428 -41.6144391...
 -41.61445183 -41.61445277 -41.6144839  -41.61451838 -41.61452958...
 -41.61453459 -41.61460664 -41.61471813 -41.61489647 -41.61497897...
 -41.61500087 -41.61500942 -41.61503109 -41.61505053 -41.61510892...
 -41.61511486 -41.6151337  -41.6151336  -41.61513729 -41.61514104...
 -41.6151646  -41.61519548 -41.61520279 -41.61523558 -41.61525537...
 -41.61529638 -41.61535608 -41.61535819 -41.61537838 -41.61540268...
 -41.61542313 -41.61543076 -41.61544921 -41.61547179 -41.61549343...
 -41.61549973 -41.61561155 -41.61563843 -41.61564481 -41.61565293...
 -41.61566617 -41.61567241 -41.61567506 -41.61569469 -41.61570754...
 -41.61571042 -41.61572004 -41.61572036 -41.61572074 -41.61572133...
 -41.61572116 -41.61572775 -41.61573306 -41.61573155 -41.61573166];
kappa2 =  [0.05288196];
kb1 =  [0.01311938];
kb2 =  [2.1242917];
kb3 =  [2.61364112];
l22 =  [ -9.02086819  -9.74231744 -10.50998259 -11.30284162 -25.86584621...
 -27.23907478 -28.6798527  -29.99684612 -31.48346524 -33.03488096...
 -37.06038263 -35.78898153 -36.92065085 -39.49400791 -39.77805372...
 -40.65320553 -40.2976832  -39.77279774 -39.13691686 -37.21891857...
 -35.78779499 -37.08270147 -33.04197691 -31.48391997 -29.9777805...
 -28.6936716  -27.23396286 -25.85446648 -24.6438959  -23.08877792...
 -21.61528912 -20.7047974  -20.37955608 -21.8445399  -23.09268604...
 -24.62107041 -25.74253607 -26.97901877 -28.35920463 -29.83465195...
 -29.87501294 -29.93946572 -30.007359   -30.06167499 -30.15896308...
 -30.31580253 -30.55050803 -30.39539108 -30.98610477 -33.06077209...
 -29.72786453 -29.34079602 -30.27743214 -30.18602343 -30.59322572...
 -28.08400943 -29.74488805 -29.45822435 -31.49747219 -31.81767754...
 -32.21620998 -32.0999558  -32.39761378 -33.6080934  -31.22000888...
 -30.5866783  -30.16053661 -30.06225986 -29.88397134 -30.19067615...
 -30.42237244 -28.60578331 -30.34520342 -30.96871316 -32.92107068...
 -30.89745898 -30.68401972 -30.6498155  -30.80731123 -30.76620203...
 -30.79169926 -30.94946038 -30.94556557 -30.75820361 -29.1770189...
 -32.45303896 -33.79587205 -35.38408654 -37.08657916 -38.87821319...
 -40.43147019 -42.23012511 -44.32140206 -46.67431096 -53.64328414];
psi2 =  [-2.09850434e-22  1.48393267e-21  4.66018403e-22 -8.19553821e-22...
 -2.28871565e-22  8.42522374e-23  4.62510173e-22 -1.41688832e-22...
 -7.89023795e-22 -1.39469371e-21  8.51191712e-23 -3.89871748e-22...
  7.70335343e-22 -5.45245076e-23  8.88520711e-22 -2.70351679e-21...
 -2.41700174e-22 -7.43893195e-22  6.46341689e-22  7.77365291e-23...
 -1.05959289e-21  1.59659331e-21  4.76197626e-22 -8.36374350e-22...
 -2.28102673e-22 -2.40641683e-22  6.27649631e-23  7.51279361e-23...
 -2.04815711e-22 -1.75549350e-22 -4.20324901e-22  1.32846612e-22...
 -3.62730839e-22 -6.34301133e-22 -8.07240066e-24  2.47120718e-22...
 -2.03924491e-22 -3.31902273e-22 -7.44445979e-22  4.29486536e-23...
  1.57329178e-03  3.13820137e-03  4.69478797e-03  6.24311031e-03...
  7.78322668e-03  9.31519489e-03  1.08390723e-02  1.23549158e-02...
  1.38627819e-02  1.53627265e-02 -1.27356484e-01 -2.45782889e-01...
 -3.11704471e-01 -3.22639183e-01 -2.81660777e-01 -1.95883577e-01...
 -7.90756270e-02  4.72260173e-02  1.59165228e-01  2.39058598e-01...
  2.78788133e-01  2.77621979e-01  2.39550404e-01  1.72676453e-01...
  8.94784727e-02  5.44527296e-03 -6.46663146e-02 -1.10638007e-01...
 -1.28251297e-01 -1.18690964e-01 -8.74039149e-02 -4.29395509e-02...
  4.64666287e-03  4.59586081e-02  7.43001782e-02  7.68816616e-02...
  7.94685848e-02  8.20609301e-02  8.46586797e-02  8.72618154e-02...
  8.98703184e-02  9.24841699e-02  9.51033505e-02  9.77278403e-02...
  1.00357619e-01  9.54369425e-02  9.09749775e-02  8.69105936e-02...
  8.31930362e-02  7.97798188e-02  7.66351094e-02  7.37284784e-02...
  7.10339193e-02  6.85290747e-02  6.61946186e-02];
%% surface area single point
Length1 = [-58.13664782 -56.62305879 -55.35541865 -54.36863315 -44.50236237...
 -44.60665691 -44.74367158 -44.84821703 -45.23689894 -44.84363887...
 -44.64074997 -44.33047614 -43.92628889 -43.20812419 -42.96162642...
 -44.10723739 -44.05374535 -42.95355375 -43.19666538 -43.91591866...
 -44.32118041 -44.61934888 -44.82258749 -45.20438722 -44.8174368...
 -44.71073215 -44.5761525  -44.4511742  -44.35424741 -44.32328309...
 -44.35241117 -44.5695797  -44.44217036 -44.34366335 -44.32586454...
 -44.37827085 -44.45124158 -44.54695726 -44.6472269  -44.72647416...
 -44.20685243 -43.67140725 -43.1043479  -42.50879599 -41.8842803...
 -40.66596424 -38.78560476 -36.36590595 -34.04312559 -32.0081382...
 -31.84556966 -33.61130296 -33.49963638 -34.67270571 -37.34343953...
 -41.78372367 -45.10615505 -45.76462311 -46.50792284 -45.72327196...
 -44.62355177 -43.30813666 -41.42561231 -40.19873887 -38.74551579...
 -39.01964481 -40.05688372 -40.9036848  -41.42380533 -42.15601967...
 -43.02518631 -43.71180777 -43.37747661 -44.40093425 -44.97701567...
 -44.35942691 -44.65622257 -44.82136529 -44.99092415 -45.18353895...
 -45.35911933 -45.50480739 -45.67254317 -45.88999522 -44.72734406...
 -45.70830576 -45.37681068 -44.90777018 -44.24207559 -43.29798867...
 -42.00737827 -40.19451525 -37.80150298 -34.26292503 -20.89498159];
Length3 = [ -1.00000868  -1.0000022   -1.00007126  -1.00005372 -15.15153947...
 -14.47845465 -14.30946051 -14.74539794 -15.28588683 -17.5147201...
 -19.90479877 -22.85399432 -26.27897302 -30.44342063 -34.10574906...
 -35.81287985 -35.89210001 -34.10675159 -30.43800062 -26.26810205...
 -22.82819016 -19.87915237 -17.4767528  -15.26038767 -14.71068627...
 -14.27093589 -14.42274859 -15.11946734 -16.32010514 -17.95877109...
 -20.02258959 -22.28286453 -22.48545273 -20.02249124 -17.93638005...
 -16.25794401 -15.08401523 -14.42259177 -14.30518668 -14.78161922...
 -12.41538831 -10.0733488   -7.7770523   -5.50319585  -3.25892804...
  -1.88934799  -1.56958099  -2.0848924   -2.39924987  -2.21699622...
  -2.1735261   -6.78955532 -16.03008258 -23.54336065 -27.80901818...
 -27.39201961 -25.70615681 -24.96427227 -21.2009411  -17.54428866...
 -12.82061878  -8.06429264  -4.72348427  -1.98492717  -1.95378118...
  -1.81665334  -2.68937728  -5.28533157  -8.83659033 -11.72959674...
 -13.48070602 -14.23782647 -15.17846128 -12.88119101 -10.41688605...
 -12.45495294 -13.09898615 -13.94932623 -14.79178165 -15.59850752...
 -16.43286918 -17.31428138 -18.16756274 -18.94266662 -21.82027918...
 -19.71656989 -19.77847858 -20.22118011 -21.13356323 -22.66119217...
 -24.90020432 -28.10820462 -32.34350922 -38.35983891 -56.98530202];
Length2 = [ -9.31741161 -10.08660007 -10.91124138 -11.77089859  -8.59293164...
  -9.7940106  -10.77933908 -11.51028274 -12.10652569 -12.14622471...
 -12.01131354 -11.58020987 -10.85499733  -9.74175559  -8.57101591...
  -7.80991084  -7.78620009  -8.57403701  -9.74988124 -10.86532223...
 -11.59760506 -12.03268429 -12.17285573 -12.13012626 -11.53721267...
 -10.80815144  -9.82980173  -8.62276534  -7.20771879  -5.61054478...
  -3.84143506  -1.99007117  -1.91307039  -3.84350357  -5.62099065...
  -7.23168789  -8.63985125  -9.8385608  -10.81168304 -11.53313185...
 -12.88799097 -14.21725335 -15.51715069 -16.7982059  -18.05818766...
 -19.1707159  -20.14564736 -21.08561399 -22.1709166  -23.41945996...
 -23.73885861 -21.30187859 -17.37703747 -12.83655532  -8.89850627...
  -6.9330879   -6.40740945  -6.55627874  -8.49205289 -10.89351004...
 -13.77830706 -16.46649795 -18.48146316 -19.86076345 -20.25952542...
 -20.11020707 -19.34592098 -17.96334626 -16.20840729 -14.55510754...
 -13.33197326 -12.66300507 -12.30826551 -13.07211709 -14.0586964...
 -13.30104955 -12.87243456 -12.38989725 -11.90718069 -11.43178923...
 -10.94660498 -10.44579882  -9.94919256  -9.47361936  -8.36724466...
 -10.07863274 -11.13587632 -12.08344874 -12.90940347 -13.58512098...
 -14.10519729 -14.4318134  -14.58282193 -14.46373516 -13.03280016];
Length4 = [-34.49521123 -34.49521403 -34.49526544 -34.49529746 -34.49717477...
 -34.49962673 -34.50334341 -34.50458957 -34.50592624 -34.50726416...
 -34.51334032 -34.52001209 -34.52451028 -34.52672397 -34.52931315...
 -34.53317911 -34.53450614 -34.53681211 -34.54190086 -34.54211572...
 -34.54613896 -34.55080046 -34.55167562 -34.55279881 -34.55489758...
 -34.55738208 -34.56125244 -34.56273781 -34.56596585 -34.56769151...
 -34.56986279 -34.57292237 -34.57549023 -34.5777213  -34.57834512...
 -34.58102367 -34.58389275 -34.58803557 -34.59509688 -34.59608803...
 -34.59885138 -34.60177763 -34.60208517 -34.607365   -34.61011114...
 -34.63273304 -34.64057738 -34.64123242 -34.6565406  -34.69198344...
 -34.69206496 -34.69212473 -34.70450939 -34.70500657 -34.7581938...
 -34.76540261 -34.7725668  -34.7778613  -34.78680137 -34.78696487...
 -34.86867956 -34.87229108 -34.88880775 -34.89226922 -34.90538624...
 -34.90782024 -34.91641713 -34.91969195 -34.93413247 -34.93925136...
 -34.94433857 -34.9457924  -34.94673905 -34.9486273  -34.9486711...
 -34.95168339 -34.95567773 -34.95581139 -34.95711133 -34.95957155...
 -34.96173227 -34.96385576 -34.96403    -34.96740968 -34.96854455...
 -34.96929609 -34.96966293 -34.97155892 -34.9785181  -34.9795021...
 -34.98045713 -34.98116694 -34.9828518  -34.98297219 -34.98400209];
kappa2 =  [0.08440577];
kb1 =  [1.68490742];
kb2 =  [1.84563553];
kb3 =  [5.10145975];
l22 =  [-10.3174203  -11.08660226 -11.91131264 -12.77095231 -23.74447111...
 -24.27246525 -25.08879959 -26.25568068 -27.39241253 -29.66094482...
 -31.91611231 -34.43420419 -37.13397035 -40.18517622 -42.67676497...
 -43.6227907  -43.67830011 -42.6807886  -40.18788186 -37.13342428...
 -34.42579522 -31.91183666 -29.64960853 -27.39051394 -26.24789894...
 -25.07908734 -24.25255032 -23.74223267 -23.52782392 -23.56931587...
 -23.86402465 -24.2729357  -24.39852312 -23.86599481 -23.5573707...
 -23.4896319  -23.72386648 -24.26115257 -25.11686973 -26.31475107...
 -25.30337928 -24.29060215 -23.29420298 -22.30140175 -21.3171157...
 -21.06006389 -21.71522835 -23.17050639 -24.57016647 -25.63645618...
 -25.91238472 -28.09143391 -33.40712005 -36.37991597 -36.70752445...
 -34.32510751 -32.11356625 -31.52055101 -29.69299399 -28.4377987...
 -26.59892583 -24.53079059 -23.20494742 -21.84569062 -22.2133066...
 -21.92686041 -22.03529827 -23.24867783 -25.04499761 -26.28470428...
 -26.81267928 -26.90083155 -27.48672679 -25.9533081  -24.47558245...
 -25.75600249 -25.9714207  -26.33922348 -26.69896234 -27.03029675...
 -27.37947416 -27.7600802  -28.1167553  -28.41628598 -30.18752384...
 -29.79520263 -30.9143549  -32.30462885 -34.04296669 -36.24631315...
 -39.00540161 -42.54001803 -46.92633115 -52.82357407 -70.01810218];
psi2 =  [-5.21777607e-20  1.21141859e-21  1.65379561e-21  2.57165035e-21...
  1.42175428e-21  6.64885697e-22 -1.05678470e-20  4.75803656e-20...
 -7.73592207e-21 -1.99690767e-21  2.43119398e-20 -2.55229360e-20...
  1.12402227e-19 -1.84688667e-20 -1.77138879e-20 -1.19611153e-20...
 -3.19660611e-20  3.18067748e-20  4.89785774e-20  6.75365023e-20...
 -1.13777211e-19  1.24767490e-20 -2.27895009e-21 -1.33469475e-20...
  4.61991917e-20 -4.73344755e-20 -1.19055751e-19 -3.77517886e-21...
  2.02295188e-21  3.57579002e-23 -1.05537758e-21 -4.11018299e-21...
 -3.05282734e-21  1.23066791e-21 -1.63011962e-21  3.04851981e-20...
  2.23033257e-22  1.63183623e-20  1.20069607e-21 -6.48598189e-21...
  1.57329178e-03  3.13820137e-03  4.69478797e-03  6.24311031e-03...
  7.78322668e-03  9.31519489e-03  1.08390723e-02  1.23549158e-02...
  1.38627819e-02  1.53627265e-02 -1.27356484e-01 -2.45782889e-01...
 -3.11704471e-01 -3.22639183e-01 -2.81660777e-01 -1.95883577e-01...
 -7.90756270e-02  4.72260173e-02  1.59165228e-01  2.39058598e-01...
  2.78788133e-01  2.77621979e-01  2.39550404e-01  1.72676453e-01...
  8.94784727e-02  5.44527296e-03 -6.46663146e-02 -1.10638007e-01...
 -1.28251297e-01 -1.18690964e-01 -8.74039149e-02 -4.29395509e-02...
  4.64666287e-03  4.59586081e-02  7.43001782e-02  7.68816616e-02...
  7.94685848e-02  8.20609301e-02  8.46586797e-02  8.72618154e-02...
  8.98703184e-02  9.24841699e-02  9.51033505e-02  9.77278403e-02...
  1.00357619e-01  9.54369425e-02  9.09749775e-02  8.69105936e-02...
  8.31930362e-02  7.97798188e-02  7.66351094e-02  7.37284784e-02...
  7.10339193e-02  6.85290747e-02  6.61946186e-02];
%% surface area with optimize diameters
Length1 = [-92.67633946 -91.44865771 -90.44288619 -89.68515456 -89.18114178...
 -88.94939655 -89.00082742 -89.32352595 -89.91668754 -90.77157717...
 -91.74539967 -92.9534024  -94.38484135 -96.01099435 -97.80092126...
 -99.72247683 -99.72247683 -97.80092126 -96.01099435 -94.38484135...
 -92.9534024  -91.74539967 -90.77162538 -89.91668829 -89.3235268...
 -89.00083513 -88.9494525  -89.18114005 -89.68515071 -90.4428877...
 -91.44865361 -92.67633928 -92.67633944 -91.44865715 -90.44288502...
 -89.68515411 -89.18113509 -88.94939997 -89.00082891 -89.32352594...
 -87.52318255 -85.70347505 -83.7081912  -81.71250322 -79.71638098...
 -77.71979122 -75.72269719 -73.72505812 -71.72682871 -69.72795844...
 -69.46761975 -73.7635337  -79.44037747 -85.42062596 -90.59240865...
 -94.11502942 -96.02683317 -96.17691784 -94.69778152 -91.90411153...
 -88.21657541 -83.95143469 -80.1497624  -77.40481632 -76.09636659...
 -76.30803274 -77.82355163 -80.20593529 -82.92153776 -85.46069301...
 -87.40152028 -88.43217032 -88.68513308 -88.25557894 -87.34390885...
 -87.97498896 -88.6065402  -89.24013653 -89.87288973 -90.50846604...
 -91.15397354 -91.77454585 -92.41321283 -93.04750476 -93.68596356...
 -93.28537377 -92.93774476 -92.5304472  -92.02015746 -91.56488161...
 -91.16546161 -90.82264952 -90.53710131 -90.30937135 -90.13990752];
Length3 = [ 0.00000000e+00  0.00000000e+00  0.00000000e+00  0.00000000e+00...
  0.00000000e+00  0.00000000e+00  0.00000000e+00  0.00000000e+00...
  1.77635684e-15  0.00000000e+00  1.77635684e-15  0.00000000e+00...
  0.00000000e+00  0.00000000e+00  0.00000000e+00  0.00000000e+00...
  0.00000000e+00  0.00000000e+00  0.00000000e+00  0.00000000e+00...
  0.00000000e+00  0.00000000e+00  0.00000000e+00  0.00000000e+00...
  0.00000000e+00  0.00000000e+00  0.00000000e+00  0.00000000e+00...
  0.00000000e+00 -8.88178420e-16  0.00000000e+00  0.00000000e+00...
  0.00000000e+00  0.00000000e+00  0.00000000e+00  0.00000000e+00...
  0.00000000e+00  0.00000000e+00  0.00000000e+00  0.00000000e+00...
  0.00000000e+00  0.00000000e+00  0.00000000e+00  0.00000000e+00...
  0.00000000e+00  0.00000000e+00  0.00000000e+00  0.00000000e+00...
  0.00000000e+00  0.00000000e+00  1.77635684e-15  0.00000000e+00...
  0.00000000e+00  0.00000000e+00 -3.24027619e-03  0.00000000e+00...
  0.00000000e+00  0.00000000e+00 -9.75972940e-04  0.00000000e+00...
 -1.77635684e-15  0.00000000e+00  0.00000000e+00  0.00000000e+00...
  0.00000000e+00  0.00000000e+00  0.00000000e+00  0.00000000e+00...
  0.00000000e+00  0.00000000e+00  0.00000000e+00  0.00000000e+00...
 -6.80157881e-05 -9.82928886e-05  0.00000000e+00  0.00000000e+00...
 -6.76947820e-04  0.00000000e+00  0.00000000e+00 -5.71345803e-04...
  1.77635684e-15  0.00000000e+00  0.00000000e+00  0.00000000e+00...
  0.00000000e+00  0.00000000e+00  0.00000000e+00  0.00000000e+00...
  0.00000000e+00  0.00000000e+00  0.00000000e+00  0.00000000e+00...
  0.00000000e+00  0.00000000e+00  0.00000000e+00];
Length2 = [ -6.26599772  -6.69120502  -7.15099325  -7.63612055  -8.13745035...
  -8.64365949  -9.14318431  -9.62634947 -10.08262495 -10.50280925...
 -10.89385017 -11.23498022 -11.52015764 -11.74682797 -11.91411864...
 -12.02259219 -12.02259219 -11.91411864 -11.74682797 -11.52015764...
 -11.23498022 -10.89385017 -10.5028039  -10.08262487  -9.62634939...
  -9.14318355  -8.6436543   -8.1374505   -7.63612087  -7.15099313...
  -6.69120531  -6.26599773  -6.26599772  -6.69120506  -7.15099334...
  -7.63612059  -8.13745094  -8.64365917  -9.14318416  -9.62634948...
  -9.84180937 -10.06792427 -10.32374435 -10.59124479 -10.87122421...
 -11.16455392 -11.47218618 -11.79516349 -12.13462926 -12.49183984...
 -12.63788993 -12.22423616 -11.6203007  -10.88559082 -10.15667837...
  -9.58855073  -9.25262745  -9.21998866  -9.46812701  -9.90491187...
 -10.4113231  -10.91154576 -11.28630954 -11.49973946 -11.55653568...
 -11.47981197 -11.2928393  -11.0206878  -10.70112187 -10.38605345...
 -10.13286677  -9.99074309  -9.95431315 -10.01114276 -10.12837124...
 -10.04829011  -9.96894279  -9.89120633  -9.81430626  -9.73789535...
  -9.66214149  -9.58965899  -9.5163747   -9.44453208  -9.37327419...
  -9.90069958 -10.42926596 -10.97123072 -11.53338002 -12.09812113...
 -12.66476095 -13.23258892 -13.80088142 -14.36890663 -14.93592967];
Length4 = [-2.06419931e+00 -1.81276988e+00 -1.55650555e+00 -1.29542408e+00...
 -1.04530081e+00 -8.04271610e-01 -5.71969640e-01 -3.63962756e-01...
 -1.78363724e-01 -1.45837033e-02  0.00000000e+00 -1.41883667e-16...
 -1.07724387e-16 -1.28155054e-16 -3.90291856e-18 -1.24651449e-17...
 -1.31987514e-16  0.00000000e+00 -1.30721168e-16 -7.55074862e-17...
 -1.52344156e-16  0.00000000e+00 -1.45357466e-02 -1.78362979e-01...
 -3.63961917e-01 -5.71962071e-01 -8.04216891e-01 -1.04530251e+00...
 -1.29542783e+00 -1.55650408e+00 -1.81277386e+00 -2.06419948e+00...
 -2.06419932e+00 -1.81277042e+00 -1.55650668e+00 -1.29542452e+00...
 -1.04530734e+00 -8.04268263e-01 -5.71968177e-01 -3.63962766e-01...
 -1.72542244e-01 -3.05503234e-17 -1.21549055e-17 -7.79342805e-17...
 -1.16916940e-16  0.00000000e+00  0.00000000e+00  0.00000000e+00...
  0.00000000e+00 -3.83961149e-19  0.00000000e+00 -1.47454267e-16...
 -8.37391732e-17 -1.30475157e-17 -1.60901119e-01 -6.08024451e-01...
 -8.51531392e-01 -8.81107513e-01 -6.90949406e-01 -3.48860000e-01...
  0.00000000e+00 -6.06811961e-17 -2.76046086e-17 -2.64745586e-17...
  0.00000000e+00 -1.26507642e-16 -1.61401942e-16 -1.35379778e-16...
  0.00000000e+00 -3.27205874e-17 -2.36758980e-02 -1.45223011e-01...
 -1.75352838e-01 -1.24900467e-01 -2.75079533e-02 -9.62744000e-02...
 -1.64327513e-01 -2.31078576e-01 -2.98409930e-01 -3.62750242e-01...
 -4.17893974e-01 -4.97455103e-01 -5.59210272e-01 -6.25348481e-01...
 -6.87431091e-01 -4.23472283e-01 -1.56535142e-01 -6.89836198e-17...
 -3.28404593e-17  0.00000000e+00 -9.80977219e-18 -4.01311880e-17...
  0.00000000e+00 -2.96623527e-16 -4.60518711e-16];
kappa2 =  [0.06959202];
kb1 =  [39.99999996];
kb2 =  [70.];
kb3 =  [100];
d1 =  [2.06946359];
d2 =  [2.3110802];
d3 =  [7.42549699];
d4 =  [7.43635747];
d5 =  [7.52494213];
d6 =  [7.53983853];
l22 =  [ -6.26599772  -6.69120502  -7.15099325  -7.63612055  -8.13745035...
  -8.64365949  -9.14318431  -9.62634947 -10.08262495 -10.50280925...
 -10.89385017 -11.23498022 -11.52015764 -11.74682797 -11.91411864...
 -12.02259219 -12.02259219 -11.91411864 -11.74682797 -11.52015764...
 -11.23498022 -10.89385017 -10.5028039  -10.08262487  -9.62634939...
  -9.14318355  -8.6436543   -8.1374505   -7.63612087  -7.15099313...
  -6.69120531  -6.26599773  -6.26599772  -6.69120506  -7.15099334...
  -7.63612059  -8.13745094  -8.64365917  -9.14318416  -9.62634948...
  -9.84180937 -10.06792427 -10.32374435 -10.59124479 -10.87122421...
 -11.16455392 -11.47218618 -11.79516349 -12.13462926 -12.49183984...
 -12.63788993 -12.22423616 -11.6203007  -10.88559082 -10.15991864...
  -9.58855073  -9.25262745  -9.21998866  -9.46910298  -9.90491187...
 -10.4113231  -10.91154576 -11.28630954 -11.49973946 -11.55653568...
 -11.47981197 -11.2928393  -11.0206878  -10.70112187 -10.38605345...
 -10.13286677  -9.99074309  -9.95438117 -10.01124106 -10.12837124...
 -10.04829011  -9.96961974  -9.89120633  -9.81430626  -9.7384667...
  -9.66214149  -9.58965899  -9.5163747   -9.44453208  -9.37327419...
  -9.90069958 -10.42926596 -10.97123072 -11.53338002 -12.09812113...
 -12.66476095 -13.23258892 -13.80088142 -14.36890663 -14.93592967];
psi2 =  [-5.00076174e-20 -1.06220884e-19  2.56938304e-20 -5.98257590e-20...
 -6.02289346e-23  4.94433685e-21  6.22335129e-23  5.57445559e-20...
  5.79468084e-21  8.15584857e-21  1.93089127e-21 -3.18326299e-21...
 -1.95443598e-20  2.29276051e-20 -9.74126400e-22  2.20340078e-21...
 -1.58059874e-20 -1.89905853e-20 -3.74070755e-20  3.04010231e-20...
 -1.21117377e-20 -3.02367095e-20 -1.73368210e-20  3.29971875e-20...
 -2.42411671e-19  1.55329105e-20  3.13420380e-20  1.45077672e-20...
 -1.75612310e-21  2.87306478e-21  2.71055492e-21 -7.62396733e-21...
 -1.75305733e-20 -1.09247881e-20  1.11455638e-19  1.27258351e-20...
  1.08360081e-20 -1.86362463e-20 -2.62409653e-20 -8.88471755e-21...
  1.57329178e-03  3.13820137e-03  4.69478797e-03  6.24311031e-03...
  7.78322668e-03  9.31519489e-03  1.08390723e-02  1.23549158e-02...
  1.38627819e-02  1.53627265e-02 -1.27356484e-01 -2.45782889e-01...
 -3.11704471e-01 -3.22639183e-01 -2.81660777e-01 -1.95883577e-01...
 -7.90756270e-02  4.72260173e-02  1.59165228e-01  2.39058598e-01...
  2.78788133e-01  2.77621979e-01  2.39550404e-01  1.72676453e-01...
  8.94784727e-02  5.44527296e-03 -6.46663146e-02 -1.10638007e-01...
 -1.28251297e-01 -1.18690964e-01 -8.74039149e-02 -4.29395509e-02...
  4.64666287e-03  4.59586081e-02  7.43001782e-02  7.68816616e-02...
  7.94685848e-02  8.20609301e-02  8.46586797e-02  8.72618154e-02...
  8.98703184e-02  9.24841699e-02  9.51033505e-02  9.77278403e-02...
  1.00357619e-01  9.54369425e-02  9.09749775e-02  8.69105936e-02...
  8.31930362e-02  7.97798188e-02  7.66351094e-02  7.37284784e-02...
  7.10339193e-02  6.85290747e-02  6.61946186e-02];
%% 
% l = [15.26815916;24.23327281;1.12428232; 16.58561056];                   % length of section 1 to 4
% psi2 = 0.16514868;
% 
% kappa2 = 1.0079047;
% kb1 =1.00186171;
% kb2 =  1.00478747;
% kb3 =  17.8372724;
link_nbr = 4;
% command (stroke(mm), angle(rad))
diam = [d6; d6; d4; d2];  % outer diameter of section 1 to 4
curv3 = (kappa2*kb2)/(kb1 + kb2 + kb3);
curv2 = (kappa2*kb2)/(kb1 + kb2);
gamma = [0; curv3; curv2; 0];             % curvature of section 1 to 4


% T = [cos(psi2) -sin(psi2) 0 0;
%        sin(psi2) cos(psi2) 0 0;
%        0 0 1 0;
%        0 0 0 1];
%T = [1 0 0 0; 0 1 0 0; 0 0 1 0; 0 0 0 1]; % intial transformation matrix

couleurs = fliplr(hsv(link_nbr));   % creates a panel of tube_nbr colors
figure,
%  scatter3(Pa(:,1)+40,Pa(:,2),Pa(:,3)-100)
%  hold on
 %for p=1:size(Length3,2)
 % 1-48,49-84
 for p=1:size(Length3,2)
    l = [Length4(p) Length3(p) Length2(p) Length1(p)];
    T = [cos(psi2(p)) -sin(psi2(p)) 0 0;
       sin(psi2(p)) cos(psi2(p)) 0 0;
       0 0 1 0;
       0 0 0 1];
   scatter3(Pa(p,1)+40,Pa(p,2),Pa(p,3)-100,'MarkerFaceColor',[0 .75 .75])
   hold on
   
    
    for i=1:link_nbr
        angle_eq = 0;
        %% plot tube portion
        q = linspace(0,2*pi,100);
        % base_i = diam(1,find(tube_flag,1,'last'))/2*[cos(q); sin(q)]; % Base curve is a circle
        base_o = diam(i)/2*[cos(q); sin(q)];
        if (gamma(i)==0)
            q = linspace(0,l(i),50);
            path = T(1:3,1:3)*[linspace(0,0,size(q,2)); linspace(0,0,size(q,2)); q] + repmat(T(1:3,4),[1 size(q,2)]); % Trajectory is a straight line
        else
            q = linspace(0,l(i)*gamma(i),50);
            path = T(1:3,1:3)*[cos(angle_eq)*(1-cos(q))/gamma(i); sin(angle_eq)*(1-cos(q))/gamma(i); sin(q)/gamma(i)] + repmat(T(1:3,4),[1 size(q,2)]); % Trajectory is an arc
        end
        % draw external surface of tube
        [Xo,Yo,Zo]=extrude(base_o,path);
        surface_o = surf(Xo,Yo,Zo); axis equal;
        set(surface_o,'FaceColor',couleurs(i,:),'EdgeColor','none');
        hold on
        xlabel('x'); ylabel('y'); zlabel('z'); % axis label
        title('kappa2=0.057')

        %% matrix of homogenious coordinates
        if (gamma(i)==0)
            T = T*[1 0 0 0;
                0 1 0 0;
                0 0 1 l(i);
                0 0 0 1]; % homogenious coordinates in case of straight portion
        else
            T = T*[cos(angle_eq)^2*(cos(gamma(i)*l(i))-1)+1 sin(angle_eq)*cos(angle_eq)*(cos(gamma(i)*l(i))-1) cos(angle_eq)*sin(gamma(i)*l(i)) cos(angle_eq)/gamma(i)*(1-cos(gamma(i)*l(i)));
                sin(angle_eq)*cos(angle_eq)*(cos(gamma(i)*l(i))-1) cos(angle_eq)^2*(1-cos(gamma(i)*l(i)))+cos(gamma(i)*l(i)) sin(angle_eq)*sin(gamma(i)*l(i)) sin(angle_eq)/gamma(i)*(1-cos(gamma(i)*l(i)));
                -cos(angle_eq)*sin(gamma(i)*l(i)) -sin(angle_eq)*sin(gamma(i)*l(i)) cos(gamma(i)*l(i)) sin(gamma(i)*l(i))/gamma(i);
                0 0 0 1]; % homogenious coordinates in case of curved portion
        end
    end
 end