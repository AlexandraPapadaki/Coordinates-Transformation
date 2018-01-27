--Task 1
Create table WGS84(idtest number PRIMARY KEY, geom sdo_geometry);

Insert into user_sdo_geom_metadata values('WGS84','geom',
            sdo_dim_array( 
            sdo_dim_element('Lon',-180,180,0.001),
            sdo_dim_element('Lat',-90,90,0.001)),4326);
Insert into WGS84 values(1, sdo_geometry(2001, 4326, sdo_point_type(13.34278,52.50944,null),null,null));

Create table GK(idtest number PRIMARY KEY,geom sdo_geometry);
INSERT INTO USER_SDO_GEOM_METADATA VALUES (
  'GK', 'GEOM', SDO_DIM_ARRAY( 
  SDO_DIM_ELEMENT( 'Easting', 4386596.4101, 4613610.5843, 0.05),
  SDO_DIM_ELEMENT( 'Northing', 5237914.5325, 6104496.9694, 0.05)
  ), 31468);

Insert into GK values(1, sdo_geometry(2001, 31468,sdo_point_type(4589981.76,5820715.67,null),null,null));

Select CS1.idtest, CS2.idtest,
       sdo_geom.sdo_distance(
       CS2.geom, mdsys.sdo_cs.transform(CS1.geom,31468), 0.001) as distance
from WGS84 CS1, GK CS2
where CS1.idtest = CS2.idtest;

--Task 2 
Insert into WGS84 values(2, sdo_geometry (2003, 4326, null, sdo_elem_info_array(1, 1003, 3), sdo_ordinate_array(12,52,13,53)));

--Task 3 
Select idtest, sdo_geom.sdo_area(geom, 0.0001) as area from WGS84 where idtest = 2;

--Task 4 
Select idtest, sdo_geom.sdo_area(mdsys.sdo_cs.transform(geom,31468), 0.0001)
as area from WGS84 where idtest = 2;

--Task 5
Select idtest, sdo_geom.sdo_area(mdsys.sdo_cs.transform(geom,31467), 0.0001)
as area from WGS84 where idtest = 2;

--This is an effect of different spatial distortions of the several projection. During the application of the various transformations,
--the coordinates of the points are affected in different ways according to the series of the transformations, the 
--parameters and deformations of each system.

