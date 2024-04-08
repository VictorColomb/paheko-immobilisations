{{if !$entry && !$entries}}
    {{:error message="Fonction 'entry_delete_prompt' : paramètre entry ou entries manquant !"}}
{{/if}}

{{if $entry}}
    {{:assign var="entries." value=$entry}}
{{/if}}

<p class="num" style="margin: 1em;">
    {{#foreach from=$entries item="entry"}}
        {{#transactions id=$entry}}
            {{:link href="!acc/transactions/delete.php?id=%d"|args:$entry label="#%s"|args:$entry target="_dialog"}}
        {{else}}
            <span href="{{$root_url}}/acc/transactions/delete.php?id={{$entry}}" style="border-radius: .5rem; padding: 0 .3rem; background: grey;">
                #{{$entry}}
            </span>
        {{/transactions}}
    {{/foreach}}
</p>
