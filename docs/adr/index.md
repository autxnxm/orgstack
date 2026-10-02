---
---

# Architecture Decision Records

{% assign adrs = site.pages | where_exp: "p", "p.path contains 'adr/'" | sort: "path" %}
{% for adr in adrs %}
{% unless adr.path contains 'index' or adr.path contains 'template' %}
{% assign adr_file = adr.path | split: '/' | last | replace: '.md', '.html' %}
- [{{ adr.path | remove: 'adr/' | remove: '.md' | replace: '-', ' ' }}]({{ adr_file }})
{% endunless %}
{% endfor %}
