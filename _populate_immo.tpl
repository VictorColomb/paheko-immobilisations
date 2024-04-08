{{if !$immo}}
    {{:error message="Fonction 'populate_immo': paramètre immo manquant !"}}
{{/if}}

{{#transactions id=$immo.entry}}
    {{:api
        path="accounting/transaction/%d"|args:$immo.entry
        method="GET"
        assign="result"
        fail=false
    }}

    {{:assign var="immo.date" value=$result.date|parse_date}}
    {{:assign var="immo.entry_label" value=$result.label}}
    {{:assign var="immo.year_id" value=$result.id_year}}

    {{:assign var="immo.amount" value=null}}
    {{#foreach from=$result.lines item="line"}}
        {{if $line.account_code|regexp_match:"/^2[01]/"}}
            {{:assign var="immo.amount" value="%d+%d"|math:$amount:$line.debit}}
            {{:assign var="immo.account_code" value=$account_code}}
            {{:assign var="immo.account_label" value="%s — %s"|args:$account_code:$account_label}}
            {{#foreach from=$line.account_selector key="key" item="value"}}
                {{:assign var="immo.account.%d"|args:$key value=$value}}
            {{/foreach}}

        {{elseif $line.account_code|regexp_match:"/^404/"}}
            {{#foreach from=$line.account_selector key="key" item="value"}}
                {{:assign var="immo.third_party_account.%d"|args:$key value=$value}}
            {{/foreach}}
        {{/if}}
    {{/foreach}}

    {{:assign var="immo.linear_amort_amount" value="%d/%d"|math:$immo.amount:$immo.duration}}

    {{:assign var="immo.vnc" value=$immo.amount}}
    {{#foreach from=$immo.amort_entries item="entry"}}
        {{#transactions id=$entry}}
            {{:api
                path="accounting/transaction/%d"|args:$entry
                method="GET"
                fail=false
                assign="result"
            }}

            {{:assign amort_amount=0}}
            {{#foreach from=$result.lines item="line"}}
                {{if $line.account_code|regexp_match:"/^28[01]/"}}
                    {{:assign amort_amount="%d+%d"|math:$amort_amount:$line.credit}}
                    {{:assign var="immo.vnc" value="%d-%d"|math:$immo.vnc:$line.credit}}
                {{/if}}
            {{/foreach}}

            {{#years id=$result.id_year}}
                {{:assign var="year_label" value=$label}}
            {{/years}}
            {{:assign date=$result.date|parse_date}}
            {{:assign
                var="amort_entries.%s-%d"|args:$date:$result.id
                id=$result.id
                year_label=$year_label
                date=$date
                amount=$amort_amount
            }}
        {{else}}
            {{:assign
                var="amort_entries.9999-99-99-"|cat:$entry
                id=$entry
                not_found=true
            }}
        {{/transactions}}
    {{/foreach}}
    {{:assign var="immo.amort_entries" value=$amort_entries|ksort}}

{{else}}
    {{:assign var="immo.not_found" value=true}}

{{/transactions}}
