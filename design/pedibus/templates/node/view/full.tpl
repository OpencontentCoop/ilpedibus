{def $openpa = object_handler($node)}
{def $show_left = false()}


<div class="openpa-full class-{$node.class_identifier}">

    <div class="container-fluid main_cage row_main_title">
        <div class="row">
            <div class="col-xs-12">
                <h1>{$node.name|wash()}</h1>
            </div>
        </div>
    </div>
    <div class="container-fluid main_cage row_content_with_side margin-both">
        <div class="row">
            <div class="col-md-12">

            {include uri=$openpa.content_main.template}

            {include uri=$openpa.content_contacts.template}

            {include uri=$openpa.content_detail.template}

            {include uri=$openpa.content_infocollection.template}

            {node_view_gui content_node=$node view=children view_parameters=$view_parameters}

            </div>

        </div>

    </div>

</div>
{ezpagedata_set('has_container',  true())}
