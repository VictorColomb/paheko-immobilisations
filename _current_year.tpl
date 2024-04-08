{{if $logged_user.preferences.accounting_year}}
    {{#years id=$logged_user.preferences.accounting_year assign="current_year"}}
    {{/years}}
{{/if}}

{{if !$current_year}}
    {{#years closed=false order="end_date DESC" assign="current_year"}}

    {{else}}
        {{#years closed=true order="end_date DESC" assign="current_year"}}
        {{/years}}
    {{/years}}
{{/if}}
