<div class="u-layout-wide u-layoutCenter u-text-r-xl partners">
    <div class="Grid Grid--withGutter u-padding-all-l u-layout-centerContent">
        {foreach $pagedata.homepage|attribute('partners').content.relation_list as $related}
            {def $valid_node = fetch( 'content', 'node', hash( 'node_id', $related.node_id ) )
                 $link = '#'}

            {if object_handler($valid_node).content_link.full_link|ne('')}
                {set $link = object_handler($valid_node).content_link.full_link}
            {/if}
            <div class="Grid-cell u-sizeFull u-sm-size1of2 u-md-size1of3 u-lg-size1of4">
                <div class="openpa-widget {$block.view} {if is_set($block.custom_attributes.color_style)}color color-{$block.custom_attributes.color_style}{/if}">
                    <div class="openpa-widget-content">
                        <div class="owl-item">
                            <div class="item">
                                {include uri='design:atoms/image.tpl' item=$valid_node image_class=carousel css_classes="" image_css_class="media-object tr_all_long_hover" alignment=center href=$link}
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            {undef $valid_node $link}
        {/foreach}
    </div>
</div>