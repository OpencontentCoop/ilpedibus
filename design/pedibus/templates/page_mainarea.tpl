{if is_set($module_result.content_info.persistent_variable.has_container)|not()}
    <div class="container-fluid main_cage row_list_box margin-bottom">
{/if}
    {$module_result.content}
{if is_set($module_result.content_info.persistent_variable.has_container)|not()}
    </div>
{/if}
