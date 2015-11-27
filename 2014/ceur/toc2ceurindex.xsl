<?xml version="1.0" encoding="utf-8"?>
<!--
    Generates a CEUR-WS.org compliant index.html page from toc.xml and workshop.xml; executed by “make ceur-ws/index.html”

    Compliance usually holds for the time when this code was last revised.

    Part of ceur-make (https://github.com/ceurws/ceur-make/)

    © Christoph Lange and contributors 2012–2015
    Sarven Capadisli 2015

    Licensed under GPLv3 or any later version
-->
<!-- Template: http://ceur-ws.org/Vol-XXX/index.html -->
<xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                exclude-result-prefixes="xs xsl"
                version="2.0">
    <xsl:output include-content-type="no" method="xhtml" omit-xml-declaration="yes" encoding="utf-8" indent="yes"/>

    <xsl:param name="all-in-one" select="false()" as="xs:boolean"/>

    <xsl:variable name="workshop" select="document('workshop.xml')/workshop"/>
    <xsl:variable name="year" select="year-from-date(xs:date(if ($workshop/date/from) then $workshop/date/from else $workshop/date))"/>
    <xsl:variable name="pubyear" select="if ($workshop/pubyear) then $workshop/pubyear else $year"/>
    <xsl:variable name="id" select="concat($workshop/title/id, $year)"/>
    <xsl:variable name="number" select="if ($workshop/number) then $workshop/number else 'XXX'"/>
    <xsl:variable name="volume" select="concat('Vol-', $number)"/>
    <xsl:variable name="volume-url" select="concat('http://ceur-ws.org/', $volume, '/')"/>

    <xsl:variable name="multi-session" select="exists(/toc/session)" as="xs:boolean"/>
    <xsl:variable name="all-papers-across-sessions" select="if ($multi-session) then /toc//paper else ()"/>

    <xsl:template match="/">
<xsl:text disable-output-escaping="yes">&lt;!DOCTYPE html&gt;</xsl:text>
<xsl:comment> CEURVERSION=2015-09-23 </xsl:comment>
<xsl:text>
</xsl:text>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
    <head>
        <meta charset="utf-8"/>
        <title>CEUR-WS.org/<xsl:value-of select="$volume"/> - <xsl:value-of select="$workshop/title/full"/> (<xsl:value-of select="$workshop/title/acronym"/>)</title>
        <link rel="stylesheet" media="all" title="CEUR-WS" href="http://ceur-ws.org/ceur-ws.css"/>
    </head>

    <body about="[this:]" prefix="schema: http://schema.org/ bibo: http://purl.org/ontology/bibo/ dbr: http://dbpedia.org/resource/ this: {$volume-url}">
        <header>
            <address>
              <a href="/"><img alt="CEUR-WS" src="http://ceur-ws.org/CEUR-WS-logo.png" width="390" height="100"/></a>
            </address>

            <dl id="document-identifier">
                <dt>Document ID</dt>
                <dd><a href="{$volume-url}"><xsl:value-of select="$volume-url"/></a></dd>
                <dt>Volume</dt>
                <dd class="CEURVOLNR" property="bibo:volume" xml:lang="" lang=""><xsl:value-of select="$volume"/></dd>
                <dt>URN</dt>
                <dd class="CEURURN" property="bibo:uri" xml:lang="" lang="">urn:nbn:de:0074-<xsl:value-of select="$number"/>-C</dd>
            </dl>

            <dl id="document-language">
                <dt>Language</dt>
                <dd class="CEURLANG" property="schema:inLanguage" xml:lang="" lang=""><xsl:value-of select="$workshop/language"/></dd>
            </dl>

            <dl id="document-license">
                <dt>Copyright</dt>
                <dd>© <span class="CEURPUBYEAR"><xsl:value-of select="$pubyear"/></span> for the individual papers by the papers' authors. Copying permitted for private and academic purposes. This volume is published and copyrighted by its editors.</dd>
            </dl>
        </header>

        <main>
            <article about="[this:]" typeof="schema:Article bibo:Proceedings">
                <h1><a class="CEURVOLACRONYM" rel="schema:url" href="{ $workshop/homepage }" property="bibo:shortTitle schema:alternateName"><xsl:value-of select="$workshop/title/acronym"/><xsl:text> </xsl:text><xsl:value-of select="$year"/></a><xsl:text> </xsl:text><span class="CEURVOLTITLE" property="schema:name"><xsl:value-of select="$workshop/title/volume"/></span></h1>

                <dl id="document-event" rel="bibo:presentedAt" resource="[this:#event]">
                    <dt typeof="schema:Event">Event</dt>
                    <dd property="schema:description">
                        <span class="CEURFULLTITLE" property="schema:name"><xsl:value-of select="$workshop/title/full"/></span>
                        <xsl:choose>
                            <xsl:when test="$workshop/conference">
                                <xsl:text> co-located with </xsl:text>
                                <xsl:if test="$workshop/conference/full"><xsl:value-of select="$workshop/conference/full"/> (</xsl:if>
                                <span class="CEURCOLOCATED">
                                <xsl:choose>
                                    <xsl:when test="$workshop/conference/homepage">
                                        <a rel="schema:isPartOf" href="{ $workshop/conference/homepage }"><xsl:value-of select="$workshop/conference/acronym"/></a>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:value-of select="$workshop/conference/acronym"/>
                                    </xsl:otherwise>
                                </xsl:choose>
                                </span>
                                <xsl:if test="$workshop/conference/full">)</xsl:if>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:comment> co-located with &lt;span class="CEURCOLOCATED"&gt;NONE&lt;/span&gt; </xsl:comment>
                            </xsl:otherwise>
                        </xsl:choose>
                    </dd>
                    <dt>Location</dt>
                    <dd class="CEURLOCATION" rel="schema:location" resource="[dbr:{ replace($workshop/location/@href, 'https?://en\.wikipedia\.org/wiki/', '') }]"><xsl:value-of select="$workshop/location"/></dd>
                    <dt>Date</dt>
                    <dd class="CEURTIME">
                        <xsl:choose>
                            <xsl:when test="$workshop/date/from and $workshop/date/to">
                                <!--
                                Possible output formats:
                                different years: (December 31st, 2013) to (January 1st, 2014)
                                same year, different months: (November 30th) to (December 1st, 2013)
                                same year, same month: (December 30th) to (31st, 2013)
                                -->
                                <xsl:variable name="same-year" select="year-from-date($workshop/date/from) eq year-from-date($workshop/date/to)"/>
                                <xsl:variable name="same-year-and-month" select="$same-year and month-from-date($workshop/date/from) eq month-from-date($workshop/date/to)"/>
                                <time property="schema:startDate" content="{ $workshop/date/from }" datatype="xsd:dateTime"><xsl:value-of select="format-date(xs:date($workshop/date/from), concat('[MNn] [D1o]', if (not($same-year)) then ', [Y]' else ''))"/></time>
                                <xsl:text> to </xsl:text>
                                <time property="schema:endDate" content="{ $workshop/date/to }" datatype="xsd:dateTime"><xsl:value-of select="format-date(xs:date($workshop/date/to), concat(if (not($same-year-and-month)) then '[MNn] ' else '', '[D1o], [Y]'))"/></time>
                            </xsl:when>
                            <xsl:otherwise>
                                <time property="schema:startDate schema:endDate" content="{ $workshop/date }" datatype="xsd:date" datetime="{ $workshop/date }"><xsl:value-of select="format-date(xs:date($workshop/date), '[MNn] [D1o], [Y]')"/></time>
                            </xsl:otherwise>
                        </xsl:choose>
                    </dd>
                </dl>

                <div id="authors">
                    <dl id="author-name">
                        <dt>Editors</dt>
                        <xsl:for-each select="$workshop/editors/editor">
                            <xsl:variable name="editorIRI">
                                <xsl:text>[this:#</xsl:text>
                                <xsl:value-of select="replace(normalize-space(name), '\s+', '')"/>
                                <xsl:text>]</xsl:text>
                            </xsl:variable>
                            <dd id="author-{position()}" rel="bibo:editor" resource="{$editorIRI}"><span about="[this:]" rel="schema:contributor schema:author schema:editor{if (@submitting='true') then ' schema:creator' else ''}">
                            <xsl:choose>
                                <xsl:when test="homepage">
                                    <a class="CEURVOLEDITOR" about="{$editorIRI}" typeof="schema:Person" rel="schema:url" property="schema:name" href="{homepage}"><xsl:value-of select="name"/></a>
                                </xsl:when>
                                <xsl:otherwise>
                                    <span class="CEURVOLEDITOR"><xsl:value-of select="name"/></span>
                                </xsl:otherwise>
                            </xsl:choose>
                            </span><sup><a about="{$editorIRI}" rel="schema:memberOf" resource="[this:#{replace(normalize-space(affiliation), '\s+', '')}]" href="#author-org-{position()}"><xsl:value-of select="position()"/></a></sup></dd>
                        </xsl:for-each>
                    </dl>

                    <ul id="author-org">
                        <xsl:for-each select="$workshop/editors/editor">
                            <li id="author-org-{position()}"><sup><xsl:value-of select="position()"/></sup>
                            <xsl:choose>
                                <xsl:when test="affiliationHomepage">
                                    <a about="[this:#{replace(normalize-space(affiliation), '\s+', '')}]" typeof="schema:Organization" property="schema:name" rel="schema:url" href="{replace(normalize-space(affiliationHomepage), '\s+', '')}"><xsl:value-of select="affiliation"/></a>
                                </xsl:when>
                                <xsl:otherwise>
                                    <span about="[this:#{replace(normalize-space(affiliation), '\s+', '')}]" typeof="schema:Organization" property="schema:name"><xsl:value-of select="affiliation"/></span>
                                </xsl:otherwise>
                            </xsl:choose>, <xsl:value-of select="country"/></li>
                        </xsl:for-each>
                    </ul>
                </div>

                <div id="content">
                    <section class="CEURTOC" id="table-of-contents" rel="schema:hasPart" resource="[this:#table-of-contents]">
                        <h2 property="schema:name">Table of Contents</h2>
                        <div property="schema:description" datatype="rdf:HTML">
                            <!--
                            XXX: Preface
                            <ol rel="schema:hasPart">
                                <li id=""><a href="">Preface</a></li>
                            </ol>
                            -->

                            <!-- <toc> is expected to either contain a sequence of <paper> elements or a sequence of <session> elements.  However we also gracefully handle the occurrence of both, in which case we first output all <paper>s without a session, then the <session>s. -->
                            <xsl:if test="/toc/paper">
                                <ol rel="schema:hasPart">
                                    <xsl:apply-templates select="/toc/paper"/>
                                </ol>
                            </xsl:if>

                            <xsl:apply-templates select="/toc/session"/>
                        </div>
                    </section>

                    <xsl:if test="$all-in-one">
                    <p>The whole proceedings can also be downloaded as a single file (<a rel="rdfs:seeAlso" href="{concat($id, '-complete.pdf')}">PDF</a>, including title pages, preface, and table of contents).</p>
                    </xsl:if>
                    <p>We offer a <a href="{$id}.bib">BibTeX file</a> for citing papers of this workshop from LaTeX.</p>
                </div>
            </article>
        </main>

        <footer>
            <xsl:variable name="dateCreated" select="format-date(current-date(), (: old format: '[D]-[MNn,*-3]-[Y]' :) '[Y]-[M,2]-[D,2]')"/>
            <p><time datetime="{$dateCreated}"  property="schema:dateCreated" content="{$dateCreated}" datatype="xsd:date"><xsl:value-of select="$dateCreated"/></time>: submitted by <xsl:value-of select="$workshop/editors/editor[@submitting='true']/name"/>, metadata incl. bibliographic data published under <a href="http://creativecommons.org/publicdomain/zero/1.0/">Creative Commons CC0</a></p>
            <p><time class="CEURPUBDATE" datetime="YYYY-MM-DD" property="schema:datePublished" content="YYYY-MM-DD" datatype="xsd:date">YYYY-MM-DD</time>: published on CEUR-WS.org</p>
        </footer>
    </body>
</html>
    </xsl:template>

    <xsl:template match="session">
        <xsl:variable name="sessionName">
            <xsl:number/><xsl:if test="title">
            <xsl:text>: </xsl:text>
            <xsl:value-of select="title"/>
            </xsl:if>
        </xsl:variable>

        <xsl:variable name="sessionIRI">
            <xsl:text>[this:#</xsl:text>
            <xsl:value-of select="replace(normalize-space($sessionName), '\s+', '')"/>
            <xsl:text>]</xsl:text>
        </xsl:variable>

        <section about="[this:#table-of-contents]" rel="schema:hasPart" resource="{$sessionIRI}">
            <h3 about="{$sessionIRI}" property="schema:name" class="CEURSESSION">Session <xsl:value-of select="$sessionName"/></h3>
            <div about="{$sessionIRI}" property="schema:description">
                <ol rel="schema:hasPart">
                    <xsl:apply-templates select="paper"/>
                </ol>
            </div>
        </section>
    </xsl:template>

    <xsl:template match="paper">
        <xsl:variable name="position">
            <xsl:choose>
                <xsl:when test="$multi-session">
                    <xsl:variable name="prev-papers-in-same-session" select="preceding::paper"/>
                    <xsl:variable name="ancestors" select="ancestor::node()"/>
                    <!-- $ns1[count(.|$ns2) = count($ns2)] == $ns1 intersect $ns2 -->
                    <xsl:variable name="prev-papers-in-other-branches" select="
                    $all-papers-across-sessions
                    [count(.|$prev-papers-in-same-session) = count($prev-papers-in-same-session)
                    or
                    count(.|$ancestors) = count($ancestors)]"/>
                    <xsl:value-of select="count($prev-papers-in-other-branches) + 1"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="position()"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

        <xsl:variable name="id">
            <xsl:choose>
                <xsl:when test="@id != ''">
                    <xsl:value-of select="@id"/>
                </xsl:when>
                <xsl:otherwise>
                    <!-- determine the number of this <paper> element among all <paper> elements in document order (including those in different <session> branches)-->
                    <!-- http://stackoverflow.com/a/3562716/2397768 -->
                    <xsl:value-of select="concat('paper-', format-number($position, '00'))"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

        <xsl:variable name="pdf" select="concat($id, '.pdf')"/>

        <li id="{$id}" about="[this:#{$id}]" typeof="schema:ScholarlyArticle" value="{$position}">
            <a class="CEURTITLE" about="[this:#{$id}]" rel="schema:url" property="schema:name" href="{resolve-uri($pdf, $volume-url)}"><xsl:value-of select="title"/></a>
            <xsl:if test="url"><xsl:text> </xsl:text>[<a rel="bibo:uri" href="{url}">canonical URL</a>]</xsl:if>
            <xsl:if test="pages">
            <dl class="pages">
                <dt>Pages</dt>
                <dd class="CEURPAGES"><span property="schema:pageStart" datatype="xsd:nonNegativeInteger"><xsl:value-of select="pages/@from"/></span>–<span property="schema:pageEnd" datatype="xsd:nonNegativeInteger"><xsl:value-of select="pages/@to"/></span></dd>
            </dl>
            </xsl:if>
            <dl class="authors">
                <dt>Authors</dt>
                <xsl:for-each select="authors/author">
                    <xsl:variable name="authorIRI" select="replace(normalize-space(.), '\s+', '')"/>
                <dd class="CEURAUTHOR" id="{$id}-{$authorIRI}" rel="bibo:authorList" inlist="" resource="[this:#{$id}-{$authorIRI}]"><span about="[this:#{$id}]" rel="schema:author"><span about="[this:#{$id}-{$authorIRI}]" typeof="schema:Person" property="schema:name"><xsl:value-of select="normalize-space(.)"/></span></span></dd>
                </xsl:for-each>
            </dl>
        </li>
    </xsl:template>
</xsl:stylesheet>
