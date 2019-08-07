
[![goodtables.io](https://goodtables.io/badge/github/n0rdlicht/swissbounderies-municipalities-data.svg)](https://goodtables.io/github/n0rdlicht/swissboundaries-national-data)

# Extract of national boundaries from swissBOUNDARIES3D

This is a list of the current set of the official national boundary of Switzerland, compiled by [cividi](https://cividi.ch). The metadata was collected by us through web searches and public contributions, and is provided as "best effort", without any guarantee of correctness.

**To add new datasets or make modifications, please visit our [GitHub repository](https://github.com/cividi/swissbounderies-municipalities-data) and contact us via Issues or Pull Request.**

## Preparation

A GeoPackage was created based on the [Shapefile](https://www.stadt-zuerich.ch/portal/de/index/ogd/werkstatt/shp_shapefile.html) obtained from [data.geo.admin.ch] via [opendata.swiss](https://opendata.swiss/en/dataset/swissboundaries3d-gemeindegrenzen). Derived from the GeoPackage a CSV, Preview CSV and two GeoJSON derivates are created.

For [validation](#validation) a schema and rules are available in the `schema` section of the [Datapackage](https://frictionlessdata.io/specs/data-package/).

Run `make` in the root folder to fetch and convert the data. You need to have **ogr2ogr**, **awk** and **curl** commands available on your system. *Note on Windows: make sure to have both ogr2ogr, e.g. if you have QGIS installed `C:\Program Files\QGIS 3.8\bin`, in your system path as well as the `GDAL_DATA` variable, e.g. to `C:\Program Files\QGIS 3.8\share\gdal`, set.*

If you also want to run the validation step with `make all-check` you need to have **goodtables** installed.

[![](https://assets.okfn.org/p/data/img/logo.png) Preview Data Package](https://data.okfn.org/tools/view?url=https%3A%2F%2Fraw.githubusercontent.com%2Fcividi%2Fswissboundaries-national-data%2Fmaster%2Fdatapackage.json)

## Validation

This Datapackage can be validated by running `goodtables validate datapackage.json` or on [goodtables.io](https://goodtables.io).

Validation is validatinf the datapackage itself and the referenced data based on the `schema` section in `datapackage.json`.

## Service

This repository contains a minimalist backend service API based on the [Falcon](http://falconframework.org/) framework and [Pandas DataPackage Reader](https://github.com/rgieseke/pandas-datapackage-reader). To run:

```
cd api
virtualenv env
. env/bin/activate
pip install -Ur requirements.txt
python server.py
```

At this point you should see the message "Serving on port..." Test the API using a REST client such as [RESTer](https://github.com/frigus02/RESTer) with queries such as:

`http://localhost:8000/tree?NAME=Schweiz`

Which gives you the entry for 'Schweiz'. You can adjust the amount of output with a `page` and `per_page` parameter in your query.

## License

This package is licensed by its maintainers under the Open Data Commons Attribution License.

If you intended to use these data in a public or commercial product, please
check the data sources themselves for any specific restrictions.
