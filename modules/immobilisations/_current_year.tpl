{{if $logged_user.preferences.accounting_year}}
    {{#years}}
        {{if $id == $logged_user.preferences.accounting_year}}
            {{:assign .="current_year}}
            {{:break}}
        {{/if}}
    {{/years}}
{{/if}}

{{if !$current_year}}
    {{#years closed=false order="end_date ASC" assign="current_year"}}
        {{:break}}
    {{else}}
        {{#years order="end_date ASC" assign="current_year"}}
            {{:break}}
        {{/years}}
    {{/years}}
{{/if}}
