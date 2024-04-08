{{if !$date}}
    {{:error message="Fonction 'find_year' : paramètre date manquant !"}}
{{/if}}

{{#years where="start_date <= :date AND end_date >= :date" :date=$date}}
    {{:assign amort_year_id=$id}}
    {{:assign amort_year_label=$label}}
    {{:assign amort_year_start=$start_date}}
    {{:assign amort_year_end=$end_date}}
{{/years}}

{{if !$amort_year_end}}
    {{:include file="./_current_year.tpl" keep="current_year"}}

    {{if $current_year}}
        {{:assign var="md_start" value=$current_year.start_date|substr:4}}
        {{:assign var="year_trunc_start" value=$date|substr:0:4}}
        {{if $date|substr:5 < $current_year.start_date|substr:5}}
            {{:assign var="year_trunc_start" value="%s-1"|math:$year_trunc_start}}
        {{/if}}

        {{:assign var="md_end" value=$current_year.end_date|substr:4}}
        {{:assign var="year_trunc_end" value=$date|substr:0:4}}
        {{if $date|substr:5 > $current_year.end_date|substr:5}}
            {{:assign var="year_trunc_end" value="%s+1"|math:$current_year_trunc_end}}
        {{/if}}

        {{:assign var="amort_year_start" value=$year_trunc_start|cat:$md_start}}
        {{:assign var="amort_year_end" value=$year_trunc_end|cat:$md_end}}
    {{/if}}
{{/if}}
