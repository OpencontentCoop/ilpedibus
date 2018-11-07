{ezpagedata_set('has_container',  true())}
{def $__AREA_RISERVATA_ABSENSE = fetch('content','node',hash('node_id', ezini( 'IlPedibus', 'AreaRiservataAssenza', 'ilpedibus.ini' )))}
{def $__AREA_RISERVATA_SUBSTITUTION = fetch('content','node',hash('node_id', ezini( 'IlPedibus', 'AreaRiservataSostituzione', 'ilpedibus.ini' )))}

<div class="container-fluid main_cage row_main_content margin-both reserved_area">
    <div class="row">
        <div class="col-xs-12">
            <p class="white-space">Benvenuti nell'Area Riservata per la gestione presenze Pedibus </p>
        </div>
    </div>

    <div class="row">
        <div class="col-xs-12 col-sm-6">
            <a href="{$__AREA_RISERVATA_ABSENSE.url|ezurl('no')}" class="btn action">Inserisci <br>ASSENZA</a>
        </div>
         <div class="col-xs-12 col-sm-6">
            <a href="{$__AREA_RISERVATA_SUBSTITUTION.url|ezurl('no')}" class="btn action">Inserisci  <br>SOSTITUZIONE</a>
        </div>
    </div>
</div>
