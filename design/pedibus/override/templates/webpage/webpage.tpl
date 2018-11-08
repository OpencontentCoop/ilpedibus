{ezpagedata_set('has_container',  true())}
{def $__TITLE = $node.name|wash()}
{if $node.data_map.short_name.has_content}
    {set $__TITLE = $node.data_map.short_name.content|wash()}
{/if}
<div class="container-fluid main_cage row_main_title">
    <div class="row">
        <div class="col-xs-12">
            <h1>{$__TITLE}</h1>
        </div>
    </div>
</div>

<div class="container-fluid main_cage row_main_content margin-both">
    <div class="row">
        <div class="col-xs-12">

            {if $node.data_map.image.has_content}
                {cache-block keys=concat($node.name|wash(),$node.node_id,"first_image")}
                    <img src="{$node.data_map.image.content['pedibus_editorial_image'].url|ezroot('no')}" alt="{$node.data_map.image.content.alternative_text|wash()}" title="{$node.data_map.image.content.alternative_text|wash()}"/>
                {/cache-block}
            {/if}
            {if $node.data_map.description.has_content}
                <p class="white-space">
                {attribute_view_gui attribute=$node.data_map.description}
                </p>
            {/if}
        </div>
    </div>
</div>
{def $__LIST_FILES = $node.data_map.files.content.relation_list}
{if $__LIST_FILES}
    {cache-block subtree_expiry=$__LIST_FILES keys=concat($node.name|wash(),$node.node_id,"files")}
        <div class="row_pdf">
            <div class="container-fluid main_cage">
                <div class="row">
                    <div class="col-xs-12">
                        <p class="pdf_title">Materiale Informativo da scaricare</p>
                        <ul>
                            {def $_SINGLE_FILE = ''}
                            {def $_SINGLE_NODE = ''}
                            {foreach $__LIST_FILES as $_SINGLE_FILE_REF}
                                {set $_SINGLE_NODE = fetch('content','node',hash('node_id',$_SINGLE_FILE_REF.node_id))}
                                {set $_SINGLE_FILE = $_SINGLE_NODE.data_map.file}
                                <li>
                                    <a href={concat("content/download/",
                                                $_SINGLE_FILE.contentobject_id,"/",
                                                $_SINGLE_FILE.id,"/file/",
                                                $_SINGLE_FILE.content.original_filename)|ezurl(,'full')} title="apri/scarica il file">
                                    <p><i class="fa fa-cloud-download" aria-hidden="true"></i> {$_SINGLE_NODE.name|wash()} <span>({$_SINGLE_FILE.content.mime_type_part} - {$_SINGLE_FILE.content.filesize|si( 'byte', 'kilo' )})</span></p>
                                    </a>
                                </li>
                            {/foreach}
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    {/cache-block}
{/if}

{def $__IMAGES = $node.data_map.images.content.relation_list}
{if $__IMAGES|count()|gt(1)}
    {cache-block subtree_expiry=$__IMAGES keys=concat($node.name|wash(),$node.node_id,"images")}
        <div class="row_gallery">
            <div class="text-center icon_camera">
                <i class="fa fa-camera" aria-hidden="true"></i>
            </div>
            <div class="container-fluid main_cage">
                <div class="row">
                    <div class="gallery">
                        {foreach $__IMAGES as $__KEY => $__IMAGE_RELATION}
                            {def $__IMAGE = fetch('content','node',hash('node_id',$__IMAGE_RELATION.node_id))}
                            {cache-block subtree_expiry=$__IMAGES keys=concat($node.name|wash(),$__KEY,"webpage-image-full-thumb")}
                                <div class="col-xs-6 col-sm-3 single_image">
                                    <a class="magnific" href="{$__IMAGE.data_map.image.content['original'].url|ezroot(no)}" title="{$__IMAGE.data_map.image.content.alternative_text|wash()}">
                                        <img src={$__IMAGE.data_map.image.content['pedibus_editorial_images'].url|ezroot()} alt="{$__IMAGE.data_map.image.content.alternative_text|wash()}" title="{$__IMAGE.data_map.title.content|wash()}" />
                                    </a>
                                </div>
                            {/cache-block}
                            {undef $__IMAGE}
                        {/foreach}
                    </div>
                    {if $node.data_map.youtube_video.has_content}
                        <div class="block_video">
                            <a class="popup-youtube" href="{$node.data_map.youtube_video.content}">
                                <span class="btn btn_video"><i class="fa fa-video-camera"></i> <strong>{$node.data_map.youtube_video.data_text}</strong></span>
                            </a>
                        </div>
                    {/if}
                </div>
            </div>
        </div>
    {/cache-block}
{/if}

{undef}
