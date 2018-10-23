{set-block scope=root variable=cache_ttl}0{/set-block}
{def $__LIMIT = ezini( 'IlPedibus', 'limit_availability', 'ilpedibus.ini' )}
{def $__CURRENT_TIMESTAMP = currentdate()}
{def $__AVAIABILITIES = fetch(
                                'content',
                                'list',
                                hash(
                                        'parent_node_id', $node.node_id,
                                        'class_filter_type', 'include',
                                        'class_filter_array', array('disponibilita'),
                                        'attribute_filter', array(
                                                                array( 'disponibilita/al','>=', $__CURRENT_TIMESTAMP)
                                                            ),
                                        'limit', $__LIMIT
                                    )
                        )
}

{if $__AVAIABILITIES|count()}
    {def $current_user = fetch( 'user', 'current_user' )}
    {def $__LINES_FILTER = array()}
    {if $current_user.is_logged_in}
        {if $current_user.contentobject.class_identifier|eq("user_pedibus")}
            {foreach $current_user.contentobject.data_map.lines_enable_to_read.content.relation_list as $__LINE_REF}
                {set $__LINES_FILTER = $__LINES_FILTER|append($__LINE_REF.node_id)}
            {/foreach}
        {/if}
    {/if}

    {def $__DAY_IN_SECOND = ezini( 'IlPedibus', 'seconds_on_day', 'ilpedibus.ini' )}
    {def $__DAYS_MAP = ezini( 'IlPedibus', 'days_map', 'ilpedibus.ini' )}
    {literal}
    <style>

    body {
        margin: 40px 10px;
        padding: 0;
        font-family: "Lucida Grande",Helvetica,Arial,Verdana,sans-serif;
        font-size: 14px;
    }

    #pedibuscalendar
    {
        max-width: 900px;
        margin: 0 auto;
        padding: 0 10px;
    }

    </style>
    {/literal}

    <script type="text/javascript">
    {literal}
        document.addEventListener("DOMContentLoaded", function()
        {
            (function ($)
            {
                $(document).ready(function ()
                {
                    $('#pedibuscalendar').fullCalendar(
                    {
                        header: {
                            left: 'prev,next today',
                            center: 'title',
                            right: 'month,agendaWeek,agendaDay,listMonth'
                        },
                    {/literal}
                        defaultDate: '{currentdate()|datetime('custom', '%Y-%m-%d')}',
                    {literal}
                        buttonIcons: true,
                        weekNumbers: false,
                        navLinks: true,
                        editable: false,
                        eventLimit: false,
                        events: [
    {/literal}
    {foreach $__AVAIABILITIES as $__A_KEY => $__AVAIABILITY}
        {def $__LINES_STR = ""}
        {def $__ADULTS = array()}
        {def $__DAYS = array()}
        {def $__SKIP_LOOP = false()}

        {foreach $__AVAIABILITY.data_map.linea.content.relation_list as $__KEY => $__ITEM_REF}
            {if $__LINES_FILTER|count()}
                {if $__LINES_FILTER|contains($__ITEM_REF.node_id)|not()}
                    {set $__SKIP_LOOP = true()}
                    {skip}
                {/if}
            {/if}

            {def $__ITEM = fetch('content', 'node', hash('node_id', $__ITEM_REF.node_id))}
            {set $__LINES_STR = concat($__LINES_STR, $__ITEM.name|wash())}

            {if inc($__KEY)lt($__AVAIABILITY.data_map.linea.content.relation_list|count())}
                {set $__LINES_STR = concat($__LINES_STR, ", ")}
            {/if}
            {undef $__ITEM}
        {/foreach}

        {if $__SKIP_LOOP|not()}
            {foreach $__AVAIABILITY.data_map.giorno.content.relation_list as $__KEY => $__ITEM_REF}
                {def $__ITEM = fetch('content', 'node', hash('node_id', $__ITEM_REF.node_id))}
                {set $__DAYS = $__DAYS|append( $__DAYS_MAP[$__ITEM.name|wash()|downcase()|extract_left(dec($__ITEM.name|count_chars()))] )}
                {undef $__ITEM}
            {/foreach}

            {foreach $__AVAIABILITY.data_map.volontario.content.relation_list as $__KEY => $__ITEM_REF}
                {def $__ITEM = fetch('content', 'node', hash('node_id', $__ITEM_REF.node_id))}

                {set $__ADULTS = $__ADULTS|merge( hash($__ITEM.name|wash(), $__ITEM.url|ezroot(,'full')))}

                {undef $__ITEM}
            {/foreach}

            {foreach $__ADULTS as $__ADULT => $__ADULT_URI}

                {def $__PERIOD = $__AVAIABILITY.data_map.dal.data_int}

                {if $__PERIOD|le($__AVAIABILITY.data_map.al.data_int)}
                    {if $__DAYS|contains($__PERIOD|datetime('custom', '%w'))}
                        {ldelim}
                            title: '{concat($__LINES_STR, " - ", $__ADULT)}',
                            url: {$__ADULT_URI},
                            start: '{$__PERIOD|datetime('custom', '%Y-%m-%d')}',
                            end: '{$__PERIOD|datetime('custom', '%Y-%m-%d')}'
                        {rdelim}{if inc($__A_KEY)le($__AVAIABILITIES|count())},{/if}
                    {/if}

                    {while $__PERIOD|lt($__AVAIABILITY.data_map.al.data_int )}

                        {set $__PERIOD = sum($__PERIOD,$__DAY_IN_SECOND)}

                        {if $__DAYS|contains($__PERIOD|datetime('custom', '%w'))}
                            {ldelim}
                                title: '{concat($__LINES_STR, " - ", $__ADULT)}',
                                url: {$__ADULT_URI},
                                start: '{$__PERIOD|datetime('custom', '%Y-%m-%d')}',
                                end: '{$__PERIOD|datetime('custom', '%Y-%m-%d')}'
                            {rdelim}{if inc($__A_KEY)le($__AVAIABILITIES|count())},{/if}
                        {/if}
                    {/while}
                    {undef $__PERIOD}
                {/if}
            {/foreach}
        {/if}

        {undef $__ADULTS}
        {undef $__LINES_STR}
        {undef $__DAYS}
        {undef $__SKIP_LOOP}
    {/foreach}
    {literal}
                        ],
                        eventRender: function(event, eventElement)
                        {
                            if(event.title.toLowerCase().indexOf(" verde ") > 0)
                            {
                                eventElement.addClass('green');
                            }

                            if(event.title.toLowerCase().indexOf(" blu ") > 0)
                            {
                                eventElement.addClass('blue');
                            }

                            if(event.title.toLowerCase().indexOf(" rossa ") > 0)
                            {
                                eventElement.addClass('red');
                            }

                            if(event.title.toLowerCase().indexOf(" gialla ") > 0)
                            {
                                eventElement.addClass('yellow');
                            }
                        },
                    });
                });
            })(jQuery);
        });
    {/literal}
    </script>

    <div id='pedibuscalendar'></div>
{else}
    <p>Nessuna Disponibilità presente</p>
{/if}
{undef}