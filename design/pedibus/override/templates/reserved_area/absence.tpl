{set-block scope=root variable=cache_ttl}0{/set-block}
{def $__AREA_RISERVATA = fetch('content','node',hash('node_id', ezini( 'IlPedibus', 'AreaRiservata', 'ilpedibus.ini' )))}
{def $__LINES = fetch(
                        'content',
                        'list',
                        hash(
                            'parent_node_id', ezini( 'IlPedibus', 'Linee', 'ilpedibus.ini' ),
                            'class_identifier', 'linea'
                        )
                    )}

{def $__VOLUNTEERS = fetch(
                        'content',
                        'list',
                        hash(
                            'parent_node_id', ezini( 'IlPedibus', 'Volontari', 'ilpedibus.ini' ),
                            'class_identifier', 'adulto'
                        )
                    )}

<div class="container-fluid main_cage row_main_content margin-both reserved_area">
	{if and(
				is_set($view_parameters.ok)|not(),
				is_set($view_parameters.error)|not()
			)
	}
        <div class="row">
            <div class="col-xs-12">
                <p class="white-space">Inserisci l'assenza del volontario</p>
            </div>
        </div>

        <form action="/ilpedibus_ra/absence" method="post">
            <div class="row">
                <div class="col-xs-12">
                    <h3>Data dell'assenza (richiesto)</h3>
                    <input class="date-picker form-control" id="date" name="absence_date" placeholder="MM/DD/YYYY" type="text" onkeydown="return false" value="{currentdate()|datetime( 'custom', "%d/%m/%Y")}"/>
                </div>
            </div>
            <hr>
            <div class="row">
                <div class="col-xs-12">
                    <h3>Linea (richiesto)</h3>
                    <p class="small">Seleziona la linea per la quale viene tracciata l'assenza</p>
                    <select name="absence_line">
                    {foreach $__LINES as $__LINE}
                        <option value="{$__LINE.contentobject_id}">{$__LINE.name|wash()}</option>
                    {/foreach}
                    </select>
                </div>
            </div>
            <hr>
            <div class="row">
                <div class="col-xs-12">
                    <h3>Volontario (richiesto)</h3>
                    <p class="small">Seleziona il nome del volontario per il quale viene tracciata l'assenza</p>
                    <select name="absence_volunteer">
                    {foreach $__VOLUNTEERS as $__VOLUNTEER}
                        <option value="{$__VOLUNTEER.contentobject_id}">{$__VOLUNTEER.name|wash()}</option>
                    {/foreach}
                    </select>
                </div>
            </div>
            <hr>
            <div class="row">
                <div class="col-xs-12">
                    <button type="submit" class="btn action">Salva</button>
                </div>
                <div class="col-xs-12">
                    <a href="{$__AREA_RISERVATA.url|ezroot('no')}" class="">Annulla l'inserimento</a>
                </div>
            </div>
            <input type="hidden" name="__URL__" value={$node.url|ezurl()} >
        </form>
	{elseif and(is_set($view_parameters.error),$view_parameters.error|ne(''))}
		<p>
			Si è verificato un errore
		</p>
		{if $view_parameters.error|int()|eq(2)}
			<p>
                Non è possibile creare l'assenza: contattare l'aministratore per notificare l'accaduto.
			</p>
            <div class="col-xs-12">
                <a href="{$__AREA_RISERVATA.url|ezroot('no')}" class="">Torna all'area riservata</a>
            </div>
		{elseif $view_parameters.error|int()|eq(1)}
			<p>
                Non è possibile creare l'assenza senza valori.
			</p>
            <div class="col-xs-12">
                <a href="{$__AREA_RISERVATA.url|ezroot('no')}" class="">Torna all'area riservata</a>
            </div>
		{/if}
	{elseif is_set($view_parameters.ok)}
		<p>
			Assenza creata con successo!
		</p>
		<br/>
        <div class="col-xs-12">
            <a href="{$__AREA_RISERVATA.url|ezroot('no')}" class="">Torna all'area riservata</a>
        </div>
	{/if}
</div>

<script type="text/javascript">
{literal}
    document.addEventListener("DOMContentLoaded", function()
    {
        $('.date-picker').on('keydown', function(){
            return false;
        });

        $('.date-picker').datetimepicker({
            locale: 'IT',
            format: 'DD/MM/YYYY',
            useCurrent: true
        });
    });
{/literal}
</script>