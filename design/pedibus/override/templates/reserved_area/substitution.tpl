{ezpagedata_set('has_container',  true())}
{set-block scope=root variable=cache_ttl}0{/set-block}
{def $__AREA_RISERVATA = fetch('content','node',hash('node_id', ezini( 'IlPedibus', 'AreaRiservata', 'ilpedibus.ini' )))}

{def $__CURRENT_TIMESTAMP = currentdate()}
{def $__MONTH_SECONDS = 2592000}


{def $__VOLUNTEERS = fetch(
                            'content',
                            'list',
                            hash(
                                'parent_node_id', ezini( 'IlPedibus', 'Volontari', 'ilpedibus.ini' ),
                                'class_identifier', 'adulto'
                            )
)}

{def $__ABSENCES = fetch(
                            'content',
                            'list',
                            hash(
                                'parent_node_id', ezini( 'IlPedibus', 'Assenze', 'ilpedibus.ini' ),
                                'class_filter_type', 'include',
                                'class_filter_array', array('assenza_volontario'),
                                'attribute_filter', array(
                                                            array( 'assenza_volontario/data','>=', sub($__CURRENT_TIMESTAMP,mul( $__MONTH_SECONDS, ezini( 'IlPedibus', 'absences_months', 'ilpedibus.ini' ) )))
                                ),
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
                <p class="white-space">Inserisci la sostituzione di un volontario</p>
            </div>
        </div>
        {if and(
                $__VOLUNTEERS|count(),
                $__ABSENCES|count()
                )
        }
            <form action="{'/ilpedibus_ra/substitution'|ezurl(no)}" method="post">
                <div class="row">
                    <div class="col-xs-12">
                        <h3>Assenza (richiesto)</h3>
                        <p class="small">Seleziona l'assenza da sostituire</p>
                        <select name="substitution_absence" class="form-control">
                        {foreach $__ABSENCES as $__ABSENCE}
                            {* PATCH: il fetch delle assenze anche se filtrato per 'assenza_volontario' prende
                            tutti i suoi figli *}
                            {def $__VOLONTARIO = fetch('content','node',hash('node_id', $__ABSENCE.data_map.volontario.content.relation_list[0].node_id))}
                            {def $__DATA = $__ABSENCE.data_map.data.data_int|datetime('custom', '%d/%m/%Y')}
                            {def $__LINEA = fetch('content','node',hash('node_id', $__ABSENCE.data_map.linea.content.relation_list[0].node_id))}
                            <option value="{$__ABSENCE.contentobject_id}">
                                {$__VOLONTARIO.name|wash()}&nbsp;-&nbsp;{$__DATA}&nbsp;-&nbsp;{$__LINEA.name|wash()}
                            </option>
                        {/foreach}
                        </select>
                    </div>
                </div>
                <hr>
                <div class="row">
                    <div class="col-xs-12">
                        <h3>Volontario (richiesto)</h3>
                        <p class="small">Seleziona il volontario che sopperisce all'assenza</p>
                        <select name="substitution_volunteer" class="form-control">
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
                        <a href="{$__AREA_RISERVATA.url|ezurl('no')}" class="">Annulla l'inserimento</a>
                    </div>
                </div>
                <input type="hidden" name="__URL__" value={$node.url|ezurl()} >
            </form>
        {else}
			<p>
                <strong>
                    Non è possibile creare la sostituzione: mancano {if $__VOLUNTEERS|count()|eq(0)}i volontari{elseif $__ABSENCES|count()|eq(0)}le assenze da sostiture{/if}
                </strong>
			</p>
            <div class="col-xs-12">
                <a href="{$__AREA_RISERVATA.url|ezurl('no')}" class="">Torna all'area riservata</a>
            </div>
        {/if}
	{elseif and(is_set($view_parameters.error),$view_parameters.error|ne(''))}
		<p>
			Si è verificato un errore
		</p>
		{if $view_parameters.error|int()|eq(2)}
			<p>
                <strong>
                    Non è possibile creare la sostituzione: contattare l'aministratore per notificare l'accaduto.
                </strong>
			</p>
            <div class="col-xs-12">
                <a href="{$__AREA_RISERVATA.url|ezurl('no')}" class="">Torna all'area riservata</a>
            </div>
		{elseif $view_parameters.error|int()|eq(1)}
			<p>
                <strong>
                    Non è possibile creare la sostituzione senza valori.
                </strong>
			</p>
            <div class="col-xs-12">
                <a href="{$__AREA_RISERVATA.url|ezurl('no')}" class="">Torna all'area riservata</a>
            </div>
		{/if}
	{elseif is_set($view_parameters.ok)}
		<p>
            <strong>
                Sostituzione creata con successo!
            </strong>
		</p>
		<br/>
        <div class="col-xs-12">
            <a href="{$__AREA_RISERVATA.url|ezurl('no')}" class="">Torna all'area riservata</a>
        </div>
	{/if}
</div>
