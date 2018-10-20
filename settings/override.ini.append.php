<?php /*

## HOMEPAGE
[ilpedibus_homepage]
Source=node/view/full.tpl
MatchFile=homepage/homepage.tpl
Subdir=templates
Match[class_identifier]=homepage

## REDAZIONALE UTENTI LIST
[ilpedibus_pagina_utenti]
Source=node/view/full.tpl
MatchFile=webpage/users.tpl
Subdir=templates
Match[class_identifier]=pagina_sito
Match[node]=1238

## REDAZIONALE WEBPAGE LIST
[ilpedibus_pagina_sito_list]
Source=node/view/full.tpl
MatchFile=webpage/users.tpl
Subdir=templates
Match[class_identifier]=pagina_sito
Match[node]=1280

## DISPONIBILITA'
[ilpedibus_webpage_avaiability]
Source=node/view/full.tpl
MatchFile=avaiability/avaiability.tpl
Subdir=templates
Match[class_identifier]=avaiables_container

## ASSENZE E SOSTITUZIONI
[ilpedibus_webpage_not_avaiability]
Source=node/view/full.tpl
MatchFile=not_avaiability/not_avaiability.tpl
Subdir=templates
Match[class_identifier]=not_avaiable_container

## Calendario
[ilpedibus_webpage_calendar]
Source=node/view/full.tpl
MatchFile=calendar/calendar_list.tpl
Subdir=templates
Match[class_identifier]=pedibus_page
#Match[node]=1232

[ilpedibus_pagina_sito]
Source=node/view/full.tpl
MatchFile=webpage/webpage.tpl
Subdir=templates
Match[class_identifier]=pagina_sito

## LINEE
[ilpedibus_webpage_lines]
Source=node/view/full.tpl
MatchFile=lines/webpage_lines.tpl
Subdir=templates
Match[class_identifier]=lines_container

[ilpedibus_webpage_line]
Source=node/view/full.tpl
MatchFile=lines/webpage_line.tpl
Subdir=templates
Match[class_identifier]=linea

## FERMATE
[ilpedibus_webpage_stop]
Source=node/view/full.tpl
MatchFile=stops/webpage_stop.tpl
Subdir=templates
Match[class_identifier]=fermata

[ilpedibus_webpage_stops]
Source=node/view/full.tpl
MatchFile=stops/webpage_stops.tpl
Subdir=templates
Match[class_identifier]=stops_container

## ADULTI
[ilpedibus_webpage_adults]
Source=node/view/full.tpl
MatchFile=adults/webpage_adults.tpl
Subdir=templates
Match[class_identifier]=adults_container

[ilpedibus_webpage_adult]
Source=node/view/full.tpl
MatchFile=adults/webpage_adult.tpl
Subdir=templates
Match[class_identifier]=adulto

## GENITORI
#:Stesso template di adulti, differenziato per permesso classi
[ilpedibus_parents_container]
Source=node/view/full.tpl
MatchFile=adults/webpage_adults.tpl
Subdir=templates
Match[class_identifier]=parents_container

## BAMBINI
[ilpedibus_webpage_childs]
Source=node/view/full.tpl
MatchFile=childs/webpage_childs.tpl
Subdir=templates
Match[class_identifier]=childs_container

## AREA RISERVATA
[ilpedibus_reserved_area]
Source=node/view/full.tpl
MatchFile=reserved_area/reserved_area.tpl
Subdir=templates
Match[class_identifier]=reserved_area

[ilpedibus_reserved_area_absense]
Source=node/view/full.tpl
MatchFile=reserved_area/absence.tpl
Subdir=templates
Match[class_identifier]=reserved_area_absense

[ilpedibus_reserved_area_substitution]
Source=node/view/full.tpl
MatchFile=reserved_area/substitution.tpl
Subdir=templates
Match[class_identifier]=reserved_area_substitution
