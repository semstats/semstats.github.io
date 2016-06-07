# Classifications

## Introduction

The SemStats 2016 challenge data sets includes data about the central economic classifications published by the UNSD and Eurostat, as well as some national classifications that are articulated with the central classifications. The international economic classifications form a very coherent system which is, for example, described briefly on [this page](http://ec.europa.eu/eurostat/statistics-explained/index.php?title=NACE_background).

For the challenge data, a subset of this central system is made available as RDF, completed with national classifications. Previous versions of the central classifications are also included in order to provide use cases related to the evolution in time of the classification system.

More precisely:

* The classification of economic activities at UN level is the ISIC. The last two versions of ISIC, revisions 3.1 and 4 are included, as well as the historical correspondence table between them.
* At the European statistical system (ESS) level, a refinement of the ISIC, called NACE, is used. Here again, the last two versions are included in the challenge data: NACE revision 1.1 and NACE revision 2. The historical correspondence between these two versions is also included, as well as the hierarchical correspondences between NACE revision 2 and ISIC revision 4.
* The following national activity classifications for the following countries are also provided in their latest versions: France and Italy (NAF and Ateco with their hierarchical correspondence to NACE), and US (NAICS and its correspondence with ISIC).
* Regarding products, the UN classification is the CPC (Central Products Classification). The last two versions of the CPC (versions 2 and 2.1) are articulated with ISIC Rev. 4. The previous version (1.1) is articulated with ISIC Rev. 3.1. All these classifications and tables are included in the data sets.
* The ESS classification for products is the CPA. Its articulation with NACE is similar to what exists between CPC and ISIC: the last two versions of the CPA (versions 2008 and 2.1) are articulated with NACE Rev. 2, and the previous version (2002) is articulated with NACE Rev. 1.1. Only versions 2008 and 2.1 of the CPC are included, with their historical correspondence and their correspondences with NACE Rev. 2.

The following picture gives an overview of the challenge data: the yellow dots represent the classifications and the yellow lines the correspondence tables.

![Challenge data overview](http://semstats.org/media/images/classifications.png)

## Vocabularies

The main RDF vocabulary used for representing classifications is [XKOS](http://www.ddialliance.org/Specification/RDF/XKOS), published by the DDI Alliance. XKOS extends [SKOS](https://www.w3.org/2004/02/skos) and is aligned with the Neuchâtel model and the GSIM classification model, which are the business models used by statisticians.
