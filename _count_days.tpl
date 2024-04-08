{{if !$start || !$end}}
    {{:error message="Fonction 'count_days' : paramètre start ou end manquant !"}}
{{/if}}

{{if $start == $end}}
    {{:assign number_of_days=0}}

{{else}}
    {{:assign start_seconds=$start|strtotime}}
    {{:assign end_seconds=$end|strtotime}}

    {{:assign var="number_of_days" value="(%d-%d) / 86400 + 1"|math:$end_seconds:$start_seconds|floatval}}
{{/if}}
