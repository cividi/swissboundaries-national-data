# Project : Data Package Makefile
# -----------------------------------------------------------------------------
# Author : Thorben Westerhuys <thorben@cividi.ch>
# -----------------------------------------------------------------------------
# License : GNU General Public License
# -----------------------------------------------------------------------------
# This Data Package is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# The Data Package is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with the Data Package. If not, see <http://www.gnu.org/licenses/>.

DATA_URL = https://data.geo.admin.ch/ch.swisstopo.swissboundaries3d-gemeinde-flaeche.fill/data.zip
DATA_NAME = swissbounderies-national
DATASET = SHAPEFILE_LV95_LN02
DATASET_FILE = swissBOUNDARIES3D_1_3_TLM_LANDESGEBIET
# DATA_SQL = select primaryindex,kategorie,quartier,strasse,baumgattunglat,baumartlat,baumnamelat,baumnamedeu,baumnummer, status,baumtyp,baumtyptext,pflanzjahr,genauigkeit from Baumkataster

all: download convert preview
all-check: all goodtables-check
check-only: goodtables-check

download: fetch-data unzip cleanup-unzip
convert: conv-gpkg conv-csv conv-geojson cleanup-conv
preview: preview-extract

fetch-data:
	curl -X GET -L $(DATA_URL) > data/$(DATA_NAME).zip

unzip:
	cd data && unzip -d $(DATA_NAME) $(DATA_NAME)
	cd data/$(DATA_NAME)/ && unzip -d ../ $(DATASET)

conv-gpkg:
	cd data && ogr2ogr -t_srs "EPSG:4326" $(DATA_NAME).gpkg $(DATASET)/$(DATASET_FILE).shp
	cd data && ogr2ogr -t_srs "EPSG:2056" $(DATA_NAME)-lv95.gpkg $(DATASET)/$(DATASET_FILE).shp

conv-csv:
	cd data && ogr2ogr -t_srs "EPSG:4326" $(DATA_NAME).csv $(DATA_NAME).gpkg

conv-geojson:
	cd data && ogr2ogr -t_srs "EPSG:4326" $(DATA_NAME).geojson $(DATA_NAME).gpkg


preview-extract:
	cd data && awk "NR==1, NR==100" $(DATA_NAME).csv > preview.csv

cleanup-unzip:
	rm data/$(DATA_NAME).zip
	rm -rf data/$(DATA_NAME)/

cleanup-conv:
	rm -rf data/$(DATASET)/

goodtables-check:
	goodtables validate datapackage.json
