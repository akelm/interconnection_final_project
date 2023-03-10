%%
%% This is file `JAmChemSoc_all.bst',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% chembst.dtx  (with options: `JAmChemSoc')
%% 
%% *****
%% 
%% IMPORTANT NOTICE:
%% 
%% For the copyright see below.
%% 
%% Any modified versions of this file must be renamed
%% with new filenames distinct from JAmChemSoc_all.bst.
%% For distribution of the original source see the terms
%% for copying and modification in the file chembst.dtx.
%% 
%% This generated file may be distributed as long as the
%% original source files, as listed above, are part of the
%% same distribution. (The sources need not necessarily be
%% in the same archive or directory.)
%% 
%% *****
%% 
%% The preliminary version of this bibliographic style file has been created
%% using the `makebst' program. The original header included:
%% 
%% Copyright 1994-2005 Patrick W Daly
%% ===============================================================
%% IMPORTANT NOTICE:
%% This bibliographic style (bst) file has been generated from one or
%% more master bibliographic style (mbs) files, listed above [merlin.mbs].
%% 
%% This generated file can be redistributed and/or modified under the terms
%% of the LaTeX Project Public License Distributed from CTAN
%% archives in directory macros/latex/base/lppl.txt; either
%% version 1 of the License, or any later version.
%% ===============================================================
%% 
%% *****
%% 
%% File: chembst.dtx Copyright (C) 2008 Stephan Schenk
%%       $Id: chembst.dtx,v 1.12 2008/09/17 19:07:16 schenk Exp $
%%
%% Stephan Schenk (mail@schenk-stephan.de)
%%
%% This program may be distributed and/or modified under the
%% conditions of the LaTeX Project Public License, either version 1.3
%% of this license or (at your option) any later version.
%% The latest version of this license is in
%%   http://www.latex-project.org/lppl.txt
%%
%% *****
%%
%% This file is intended for use with:
%%       J. Am. Chem. Soc.
%%
ENTRY
  {
    address
    author
    booktitle
    chapter
    collaboration
    description
    edition
    editor
    eid
    erratumeid
    erratumgermanpages
    erratumnumpages
    erratumpages
    erratumvolume
    erratumyear
    germanpages
    howpublished
    institution
    journal
    key
    language
    month
    note
    number
    numpages
    organization
    pages
    publisher
    school
    series
    title
    type
    url
    version
    volume
    year
  }
  {}
  { label }
INTEGERS {
  before.all
  i
  j
  longest.label.width
  mid.sentence
  multiresult
  nameptr
  namesleft
  new.sentence
  number.label
  numnames
  o
  output.state
}
STRINGS {
  bibinfo
  delimiter
  longest.label
  s
  t
}
FUNCTION {bbl.and} { "\bbland{}" }
FUNCTION {bbl.chap} { "\bblchap{}" }
FUNCTION {bbl.chapter} { "\bblchapter{}" }
FUNCTION {bbl.edition} { "\bbledn{}" }
FUNCTION {bbl.editor} { "\bbled{}" }
FUNCTION {bbl.editors} { "\bbleds{}" }
FUNCTION {bbl.eidp} { "\bbleidp{}" }
FUNCTION {bbl.eidpp} { "\bbleidpp{}" }
FUNCTION {bbl.erratum} { "\bblerratum{}" }
FUNCTION {bbl.etal} { "\bbletal{}" }
FUNCTION {bbl.fifth} { "\bblfiftho{}" }
FUNCTION {bbl.first} { "\bblfirsto{}" }
FUNCTION {bbl.fourth} { "\bblfourtho{}" }
FUNCTION {bbl.in} { "\bblin{}" }
FUNCTION {bbl.mthesis} { "\bblmthesis{}" }
FUNCTION {bbl.bthesis} { "\bblbthesis{}" }
FUNCTION {bbl.nd} { "\bblnd{}" }
FUNCTION {bbl.nr} { "\bblno{}" }
FUNCTION {bbl.number} { "\bblno{}" }
FUNCTION {bbl.of} { "\bblof{}" }
FUNCTION {bbl.page}{ "\bblp{}" }
FUNCTION {bbl.pages} { "\bblpp{}" }
FUNCTION {bbl.phdthesis} { "\bblphdthesis{}" }
FUNCTION {bbl.rd} { "\bblrd{}" }
FUNCTION {bbl.second} { "\bblsecondo{}" }
FUNCTION {bbl.st} { "\bblst{}" }
FUNCTION {bbl.techrep} { "\bbltechrep{}" }
FUNCTION {bbl.th} { "\bblth{}" }
FUNCTION {bbl.third} { "\bblthirdo{}" }
FUNCTION {bbl.volume} { "\bblvol{}" }
MACRO {jan} {"\bbljan{}"}
MACRO {feb} {"\bblfeb{}"}
MACRO {mar} {"\bblmar{}"}
MACRO {apr} {"\bblapr{}"}
MACRO {may} {"\bblmay{}"}
MACRO {jun} {"\bbljun{}"}
MACRO {jul} {"\bbljul{}"}
MACRO {aug} {"\bblaug{}"}
MACRO {sep} {"\bblsep{}"}
MACRO {oct} {"\bbloct{}"}
MACRO {nov} {"\bblnov{}"}
MACRO {dec} {"\bbldec{}"}
FUNCTION {delimiter.blank} { " " }
FUNCTION {delimiter.colon} { ": " }
FUNCTION {delimiter.comma} { ", " }
FUNCTION {delimiter.semicolon} { "; " }
FUNCTION {delimiter.default}
{
  delimiter.semicolon
}
FUNCTION {output.bibitem}
{
  newline$
  "\bibitem{" write$
  cite$ write$
  "}" write$
  newline$
  ""
  before.all 'output.state :=
}
FUNCTION {output.internal}
{
  'delimiter :=
  duplicate$ empty$
    'pop$
    {
      's :=
      output.state mid.sentence =
        {
          delimiter *
          write$
        }
        {
          output.state before.all =
            'write$
            { add.period$ " " * write$ }
          if$
          mid.sentence 'output.state :=
        }
      if$
      s
    }
  if$
}
FUNCTION {output.check.internal}
{
  'delimiter :=
  't :=
  duplicate$ empty$
    { pop$ "empty " t * " in " * cite$ * warning$ }
    { delimiter output.internal }
  if$
}
FUNCTION {output} { delimiter.default output.internal }
FUNCTION {output.blank} { delimiter.blank output.internal }
FUNCTION {output.comma} { delimiter.comma output.internal }
FUNCTION {output.semicolon} { delimiter.semicolon output.internal }
FUNCTION {output.check} { delimiter.default output.check.internal }
FUNCTION {output.check.blank} { delimiter.blank output.check.internal }
FUNCTION {output.check.comma} { delimiter.comma output.check.internal }
FUNCTION {output.check.semicolon} { delimiter.semicolon output.check.internal }
FUNCTION {not}
{
    { #0 }
    { #1 }
  if$
}
FUNCTION {and}
{
    'skip$
    { pop$ #0 }
  if$
}
FUNCTION {or}
{
    { pop$ #1 }
    'skip$
  if$
}
FUNCTION {multiply}
{
  'i :=
  'j :=
  #0
  j #0 =
    'skip$
    {
        { i }
        {
          j +
          i #1 - 'i :=
        }
      while$
    }
  if$
}
FUNCTION {bibinfo.check}
{
  duplicate$ missing$
    { pop$ "" }
    'skip$
  if$
}
FUNCTION {bibinfo.warn}
{
  swap$
  duplicate$ missing$
    {
      swap$ "missing " swap$ * " in " * cite$ * warning$ pop$
      ""
    }
    { duplicate$ empty$
        {
          swap$ "empty " swap$ * " in " * cite$ * warning$
        }
        { swap$
          pop$
        }
      if$
    }
  if$
}
FUNCTION {bolden}
{
  duplicate$ empty$
    { pop$ "" }
    { "\textbf{" swap$ * "}" * }
  if$
}
FUNCTION {capitalize}
{
  "\capitalize" swap$ *
}
FUNCTION {cat.internal}
{
  'delimiter :=
  duplicate$ empty$
    'pop$
    {
      swap$
      duplicate$ empty$
        'skip$
        { delimiter * }
      if$
      swap$
      *
    }
  if$
}
FUNCTION {cat.blank} { delimiter.blank cat.internal }
FUNCTION {cat.colon} { delimiter.colon cat.internal }
FUNCTION {cat.comma} { delimiter.comma cat.internal }
FUNCTION {cat.default} { delimiter.default cat.internal }
FUNCTION {cat.semicolon} { delimiter.semicolon cat.internal }
FUNCTION {eng.ord}
{
  duplicate$ "1" swap$ *
  #-2 #1 substring$ "1" =
     { bbl.th * }
     { duplicate$ #-1 #1 substring$
       duplicate$ "1" =
         { pop$ bbl.st * }
         { duplicate$ "2" =
             { pop$ bbl.nd * }
             { "3" =
                 { bbl.rd * }
                 { bbl.th * }
               if$
             }
           if$
          }
       if$
     }
   if$
}
FUNCTION {is.num}
{
  chr.to.int$
  duplicate$ "0" chr.to.int$ < not
  swap$ "9" chr.to.int$ > not and
}
FUNCTION {extract.num}
{
  duplicate$ 't :=
  "" 's :=
    { t empty$ not }
    {
      t #1 #1 substring$
      t #2 global.max$ substring$ 't :=
      duplicate$ is.num
        { s swap$ * 's := }
        { pop$ "" 't := }
      if$
    }
  while$
  s empty$
    'skip$
    { pop$ s }
  if$
}
FUNCTION {convert.edition}
{
  extract.num "l" change.case$ 's :=
  s "first" = s "1" = or
    { bbl.first 't := }
    { s "second" = s "2" = or
        { bbl.second 't := }
        { s "third" = s "3" = or
            { bbl.third 't := }
            { s "fourth" = s "4" = or
                { bbl.fourth 't := }
                { s "fifth" = s "5" = or
                    { bbl.fifth 't := }
                    { s #1 #1 substring$ is.num
                        { s eng.ord 't := }
                        { edition 't := }
                      if$
                    }
                  if$
                }
              if$
            }
          if$
        }
      if$
    }
  if$
  t
}
FUNCTION {either.or.check}
{
  empty$
    'pop$
    { "can't use both " swap$ * " fields in " * cite$ * warning$ }
  if$
}
FUNCTION {emphasize}
{
  duplicate$ empty$
    { pop$ "" }
    { "\emph{" swap$ * "}" * }
  if$
}
FUNCTION {fin.entry}
{
  add.period$
  write$ newline$
}
FUNCTION {format.names}
{
  'bibinfo :=
  duplicate$ empty$
    'skip$
    {
      's :=
      "" 't :=
      #1 'nameptr :=
      s num.names$ 'numnames :=
      numnames 'namesleft :=
        { namesleft #0 > }
        {
          s nameptr
          "{vv~}{ll}{, f.}{, jj}"
          format.name$
          bibinfo.check
          't :=
          nameptr #1 >
            {
              numnames #0
              >
              nameptr #0
              =
              and
                {
                  "others" 't :=
                  #1 'namesleft :=
                }
                'skip$
              if$
              delimiter.default *
              namesleft #1 >
                { t * }
                {
                  s nameptr "{ll}" format.name$
                  duplicate$ "others" =
                    { 't := }
                    { pop$ }
                  if$
                  t "others" =
                    { bbl.etal * }
                    { t * }
                  if$
                }
              if$
            }
            't
          if$
          nameptr #1 + 'nameptr :=
          namesleft #1 - 'namesleft :=
        }
      while$
    }
  if$
}
FUNCTION {get.bbl.editor}
{
  editor num.names$ #1 >
    'bbl.editors
    'bbl.editor
  if$
}
FUNCTION {get.bbl.erratum}
{
  bbl.erratum
  ":" *
}
FUNCTION {multi.page.check}
{
  't :=
  #0 'multiresult :=
    {
      multiresult not
      t empty$ not and
    }
    { t #1 #1 substring$
      duplicate$ "-" =
          swap$ duplicate$ "," =
          swap$ "+" =
          or or
        { #1 'multiresult := }
        { t #2 global.max$ substring$ 't := }
      if$
    }
  while$
  multiresult
}
FUNCTION {get.bbl.page}
{
  duplicate$ multi.page.check
    { bbl.pages }
    { bbl.page  }
  if$
}
FUNCTION {n.dashify}
{
  't :=
  ""
    { t empty$ not }
    {
      t #1 #1 substring$ "-" =
        {
          t #1 #2 substring$ "--" = not
            {
              "--" *
              t #2 global.max$ substring$ 't :=
            }
            {
                { t #1 #1 substring$ "-" = }
                {
                  "-" *
                  t #2 global.max$ substring$ 't :=
                }
              while$
            }
          if$
        }
        {
          t #1 #1 substring$ *
          t #2 global.max$ substring$ 't :=
        }
      if$
    }
  while$
}
FUNCTION {select.language}
{
  duplicate$ empty$
    'skip$
    {
      language empty$
        'skip$
        { "\foreignlanguage{" language * "}{" * swap$ * "}" * }
      if$
    }
  if$
}
FUNCTION {space.word}
{
  " " swap$ * " " *
}
FUNCTION {str.to.int.warn}
{
  "str.to.int: '" swap$ * "' is not a valid integer" * warning$
}
FUNCTION {str.to.int}
{
  duplicate$ empty$
    {
      str.to.int.warn
      #0
    }
    {
      duplicate$ 't :=
      t #1 #1 substring$ "-" =
        {
          t #2 global.max$ substring$ 't :=
          t empty$
            {
              duplicate$ str.to.int.warn
              #0
            }
            { #-1 }
          if$
        }
        { #1 }
      if$
      #1 'o :=
      #0
        { t empty$ not}
        {
          t #-1 #1 substring$
          duplicate$ is.num
            {
              chr.to.int$ #48 -
              o multiply
              +
              t #-2 global.max$ substring$ 't :=
              o #10 multiply 'o :=
            }
            {
              pop$ pop$
              swap$ duplicate$ str.to.int.warn
              swap$ #0
              "" 't :=
            }
          if$
        }
      while$
      multiply
      swap$ pop$
    }
  if$
}
FUNCTION {tie.or.space.prefix}
{
  duplicate$ text.length$ #3 <
    { "~" }
    { " " }
  if$
  swap$
}
FUNCTION {word.in}
{
  bbl.in delimiter.blank *
}
FUNCTION {format.year.internal}
{
  bolden
}
FUNCTION {format.volume.internal}
{
  duplicate$ empty$
    'skip$
    {
      bbl.volume
      swap$
      tie.or.space.prefix
      * *
    }
  if$
}
FUNCTION {format.authors}
{
  author "author" format.names
  duplicate$ empty$
    'skip$
    {
      collaboration bibinfo.check
      duplicate$ empty$
        'skip$
        { " (" * swap$ * ")" * }
      if$
      *
    }
  if$
}
FUNCTION {format.booktitle}
{
  booktitle bibinfo.check
  emphasize
  select.language
}
FUNCTION {format.chapter}
{
  chapter bibinfo.check
  duplicate$ empty$
    'skip$
    {
      type bibinfo.check
      duplicate$ empty$
        { pop$ bbl.chapter }
        { "l" change.case$ }
      if$
      capitalize
      swap$
      tie.or.space.prefix
      * *
    }
  if$
}
FUNCTION {format.date}
{
  year bibinfo.check
  format.year.internal
}
FUNCTION {format.edition}
{
  edition bibinfo.check
  duplicate$ empty$
    'skip$
    {
      convert.edition
      output.state mid.sentence =
        { "l" }
        { "t" }
      if$ change.case$
      " " * bbl.edition *
    }
  if$
}
FUNCTION {format.editors}
{
  editor "editor" format.names
  duplicate$ empty$
    'skip$
    {
      author empty$
        'skip$
        {
      "," *
      " " *
      get.bbl.editor
      capitalize
      *
        }
      if$
    }
  if$
}
FUNCTION {format.in.booktitle}
{
  format.booktitle
  duplicate$ empty$
    'skip$
    {
      word.in
      capitalize
      swap$ *
    }
  if$
}
FUNCTION {format.note}
{
  note bibinfo.check
}
FUNCTION {format.number.series}
{
  volume bibinfo.check
  duplicate$ empty$
    {
      number empty$
        { series bibinfo.check }
        {
          series empty$
            { number bibinfo.check }
            {
              output.state mid.sentence =
                { bbl.number }
                { bbl.number capitalize }
              if$
              number bibinfo.check tie.or.space.prefix * *
              word.in *
              series bibinfo.check *
            }
          if$
        }
      if$
    }
    'skip$
  if$
}
FUNCTION {format.org.or.pub}
{
  't :=
  address empty$ t empty$ and
    { "" }
    {
      t
      address bibinfo.check
      duplicate$ empty$
        'pop$
        {
          cat.colon
        }
      if$
    }
  if$
}
FUNCTION {format.organization.address}
{
  organization bibinfo.check
  format.org.or.pub
}
FUNCTION {format.pages}
{
  pages bibinfo.check
  duplicate$ empty$
    'skip$
    {
      n.dashify
      get.bbl.page
      swap$
      tie.or.space.prefix *
      *
    }
  if$
}
FUNCTION {format.publisher.address}
{
  publisher "publisher" bibinfo.warn
  format.org.or.pub
}
FUNCTION {format.thesis.type}
{
  type
  duplicate$ empty$
    'pop$
    {
      swap$ pop$
      "t" change.case$ bibinfo.check
    }
  if$
}
FUNCTION {format.title}
{
  title bibinfo.check
  duplicate$ empty$
    'skip$
    {
      emphasize
      select.language
    }
  if$
}
FUNCTION {format.tr.number}
{
  number bibinfo.check
  type
  duplicate$ empty$
    { pop$ bbl.techrep }
    'skip$
  if$
  bibinfo.check
  swap$
  duplicate$ empty$
    { pop$ "t" change.case$ }
    { tie.or.space.prefix * * }
  if$
}
FUNCTION {format.url}
{
  url bibinfo.check
  duplicate$ empty$
    'skip$
    {
      "\urlprefix\url{" swap$ * "}" *
      new.sentence 'output.state :=
    }
  if$
}
FUNCTION {format.volume}
{
  volume bibinfo.check
  format.volume.internal
}
FUNCTION {format.volume.and.series}
{
  volume empty$ series empty$ or
    { "" }
    {
      volume format.volume.internal
      swap$ bbl.of space.word * swap$
      emphasize
      *
      "volume and number" number either.or.check
    }
  if$
}
FUNCTION {format.volume.noseries}
{
  series empty$
    {
      volume bibinfo.check
      format.volume.internal
    }
    { "" }
  if$
}
FUNCTION {bibliography.cite}
{
  "\bibliographycite{" swap$ * "}" *
}
FUNCTION {format.crossref}
{
  bbl.in " " *
  capitalize
  crossref bibliography.cite *
}
FUNCTION {format.article.cat.journal.year}
{
  cat.blank
}
FUNCTION {format.article.year.internal}
{
  bolden
}
FUNCTION {format.article.volume.internal}
{
  emphasize
}
FUNCTION {format.article.germanpages.volume.internal}
{
  duplicate$ empty$
    'skip$
    {
      str.to.int
      duplicate$ #1 <
        {
          pop$
          "volume in " cite$ * " is not a positive integer value" * warning$
          ""
        }
        {
          #73 +
          int.to.str$
          format.article.volume.internal
        }
      if$
    }
  if$
}
FUNCTION {format.article.germanpages.pages.internal}
{
  n.dashify
}
FUNCTION {format.article.date}
{
  format.date
  format.article.year.internal
}
FUNCTION {format.article.numpages}
{
  duplicate$ empty$
    'skip$
    {
      duplicate$ "1" =
        { "~" * bbl.eidp * }
        { "~" * bbl.eidpp * }
      if$
      "(" swap$ * ")" *
    }
  if$
}
FUNCTION {format.article.eid}
{
  eid bibinfo.check
  duplicate$ empty$
    'pop$
    {
      cat.comma
    }
  if$
}
FUNCTION {format.article.journal}
{
  journal bibinfo.check
  duplicate$ empty$
    'skip$
    { emphasize }
  if$
}
FUNCTION {format.article.germanpages.journalname}
{
  "Angew.\ Chem."
  emphasize
}
FUNCTION {format.article.erratum.germanpages.pages}
{
  erratumgermanpages bibinfo.check
  format.article.germanpages.pages.internal
}
FUNCTION {format.article.erratum.year}
{
  erratumyear bibinfo.check
  format.year.internal
  format.article.year.internal
}
FUNCTION {format.article.erratum.germanpages.volume}
{
  erratumvolume "erratumvolume" bibinfo.warn
  format.article.germanpages.volume.internal
}
FUNCTION {format.article.erratum.germanpages}
{
  erratumgermanpages empty$
    { "" }
    {
      format.article.germanpages.journalname
      format.article.erratum.year format.article.cat.journal.year
      format.article.erratum.germanpages.volume cat.comma
      format.article.erratum.germanpages.pages cat.comma
    }
  if$
}
FUNCTION {format.article.erratum.journal} { format.article.journal }
FUNCTION {format.article.erratum.pages}
{
  erratumpages bibinfo.check
  n.dashify
}
FUNCTION {format.article.erratum.eid}
{
  erratumeid bibinfo.check
  erratumnumpages bibinfo.check format.article.numpages *
}
FUNCTION {format.article.erratum.volume}
{
  erratumvolume bibinfo.check
  format.article.volume.internal
}
FUNCTION {format.article.erratum}
{
  erratumyear bibinfo.check empty$
      erratumvolume bibinfo.check empty$ and
      erratumpages bibinfo.check empty$ and
      erratumeid bibinfo.check empty$ and
    { "" }
    {
      get.bbl.erratum
      format.article.erratum.journal cat.blank
      format.article.erratum.year format.article.cat.journal.year
      format.article.erratum.volume cat.comma
      erratumeid empty$
        { format.article.erratum.pages }
        { format.article.erratum.eid }
      if$
      cat.comma
      format.article.erratum.germanpages cat.semicolon
    }
  if$
}
FUNCTION {format.article.germanpages.pages}
{
  germanpages bibinfo.check
  format.article.germanpages.pages.internal
}
FUNCTION {format.article.germanpages.volume}
{
  volume "volume" bibinfo.warn
  format.article.germanpages.volume.internal
}
FUNCTION {format.article.germanpages.year} { format.article.date }
FUNCTION {format.article.germanpages}
{
  germanpages empty$
    { "" }
    {
      format.article.germanpages.journalname
      format.article.germanpages.year format.article.cat.journal.year
      format.article.germanpages.volume cat.comma
      format.article.germanpages.pages cat.comma
    }
  if$
}
FUNCTION {format.article.pages}
{
  pages
  duplicate$ empty$
    'pop$
    {
      swap$
      duplicate$ empty$
        { pop$ pop$ format.pages }
        {
          swap$
          n.dashify
          cat.comma
        }
      if$
    }
  if$
}
FUNCTION {format.article.title}
{
  title bibinfo.check
  duplicate$ empty$
    'skip$
    {
      new.sentence 'output.state :=
    }
  if$
}
FUNCTION {format.article.volume.and.number}
{
  volume bibinfo.check
  duplicate$ empty$
    'skip$
    { bibinfo.check }
  if$
  format.article.volume.internal
}
FUNCTION {format.book.authors}
{
  author empty$
    { format.editors }
    {
      format.authors
      "author and editor" editor either.or.check
    }
  if$
}
FUNCTION {format.book.editors}
{
  author empty$
    { "" }
    { format.editors }
  if$
}
FUNCTION {format.book.year}
{
  bolden
}
FUNCTION {format.book.volume.internal}
{
  volume bibinfo.check
  duplicate$ empty$
    'skip$
    {
      tie.or.space.prefix *
      bbl.volume swap$ *
    }
  if$
}
FUNCTION {format.book.volume.and.series}
{
  series bibinfo.check
  duplicate$ empty$
    'skip$
    {
      format.book.volume.internal
      cat.comma
    }
  if$
}
FUNCTION {format.book.volume.noseries}
{
  series empty$ not
    { "" }
    {
      format.book.volume.internal
    }
  if$
}
FUNCTION {misc.empty.check}
{
  author empty$ title empty$ howpublished empty$
  month empty$ year empty$ note empty$ url empty$
  and and and and and and
    { "all relevant fields are empty in " cite$ * warning$ }
    'skip$
  if$
}
FUNCTION {format.program.description}
{
  description bibinfo.check
  duplicate$ empty$
    'skip$
    { select.language }
  if$
}
FUNCTION {format.program.publisher.address}
{
  publisher bibinfo.check
  format.org.or.pub
}
FUNCTION {format.program.title}
{
  title "title" bibinfo.warn
  duplicate$ empty$
    'skip$
    {
      "t" change.case$
      " " swap$ *
      capitalize
      emphasize
    }
  if$
}
FUNCTION {format.program.version}
{
  version
}
FUNCTION {article}
{
  output.bibitem
  format.authors "author" output.check
  %output.check.blank
  format.article.journal "journal"
  output.check.blank
  format.article.date "year"
  output.check.blank
  format.article.volume.and.number output.comma
  eid empty$
    { format.article.pages }
    { format.article.eid }
  if$
  format.article.germanpages output.semicolon
  format.article.erratum output.semicolon
  format.note output
  fin.entry
}
FUNCTION {book}
{
  output.bibitem
  format.book.authors "author and editor" output.check
  format.title "title"
  output.check.blank
  format.edition
  output.comma
  format.book.editors output.semicolon
  format.book.volume.and.series output
  format.publisher.address output
  format.date "year" output.check.comma
  format.volume.noseries output.semicolon
  format.note output
  fin.entry
}
FUNCTION {booklet}
{
  output.bibitem
  format.authors output
  format.title "title" output.check
  howpublished bibinfo.check output
  address bibinfo.check output
  format.date output
  format.note output
  fin.entry
}
FUNCTION {inbook}
{
  output.bibitem
  format.book.authors "author and editor" output.check
  crossref missing$
    {
      format.title "title"
      output.check.blank
      format.edition
      output.comma
      format.book.editors output.semicolon
      format.book.volume.and.series output
      format.publisher.address output
      format.date "year" output.check.comma
      format.volume.noseries
    }
    {
      format.crossref output.blank
      ""
    }
  if$
  format.chapter cat.comma
  format.pages cat.comma
  output
  format.note output
  fin.entry
}
FUNCTION {incollection}
{
  output.bibitem
  format.authors "author" output.check
  crossref missing$
    {
      format.in.booktitle "booktitle" output.check.blank
      format.edition
      output.comma
      format.book.editors output.semicolon
      format.book.volume.and.series output
      format.publisher.address output
      format.date "year" output.check.comma
      format.volume.noseries
    }
    {
      format.crossref output.blank
      ""
    }
  if$
  format.chapter cat.comma
  format.pages cat.comma
  output
  format.note output
  fin.entry
}
FUNCTION {inproceedings}
{
  output.bibitem
  format.authors "author" output.check
  format.title "title" output.check
  crossref missing$
    {
      format.in.booktitle "booktitle" output.check.blank
      publisher empty$
        { format.organization.address output }
        {
          organization bibinfo.check output
          format.publisher.address output
        }
      if$
      format.book.volume.and.series output
    }
    { format.crossref output.blank }
  if$
  format.pages "pages" output.check
  format.note output
  format.url output
  fin.entry
}
FUNCTION {manual}
{
  output.bibitem
  author empty$
    {
      organization bibinfo.check
      duplicate$ empty$
        'pop$
        {
          output
          address bibinfo.check output
        }
      if$
    }
    { format.authors output }
  if$
  format.title "title" output.check
  author empty$
    {
      organization empty$
        { address bibinfo.check output }
        'skip$
      if$
    }
    {
      organization bibinfo.check output
      address bibinfo.check output
    }
  if$
  format.edition output
  format.date output
  format.note output
  format.url output
  fin.entry
}
FUNCTION {mastersthesis}
{
  output.bibitem
  format.authors "author" output.check
  bbl.mthesis format.thesis.type output
  school "school" bibinfo.warn output
  address bibinfo.check output
  format.date "year" output.check
  format.note output
  format.url output
  fin.entry
}
FUNCTION {bachelorthesis}
{
  output.bibitem
  format.authors "author" output.check
  bbl.bthesis format.thesis.type output
  format.title output
  school "school" bibinfo.warn output
  address bibinfo.check output
  format.date "year" output.check
  format.note output
  format.url output
  fin.entry
}
FUNCTION {misc}
{
  output.bibitem
  format.authors output
  format.title output
  howpublished bibinfo.check output
  format.date output
  format.note output
  format.url output
  fin.entry
  misc.empty.check
}
FUNCTION {phdthesis}
{
  output.bibitem
  format.authors "author" output.check
  bbl.phdthesis format.thesis.type output
  school "school" bibinfo.warn output
  address bibinfo.check output
  format.date "year" output.check
  format.note output
  format.url output
  fin.entry
}
FUNCTION {proceedings}
{
  output.bibitem
  editor empty$
    { organization bibinfo.check output }
    { format.editors output }
  if$
  format.title "title" output.check
  format.volume output
  format.number.series output
  editor empty$
    {
      publisher empty$
        'skip$
        { format.publisher.address output }
      if$
    }
    {
      publisher empty$
        { format.organization.address output }
        {
          organization bibinfo.check output
          format.publisher.address output
        }
      if$
     }
  if$
  format.note output
  format.url output
  fin.entry
}
FUNCTION {program}
{
  output.bibitem
  format.authors output
  format.program.title "title"
  output.check.blank
  format.program.description output.comma
  format.program.version output
  format.program.publisher.address output
  format.date output.comma
  format.note output
  format.url output
  fin.entry
}
FUNCTION {techreport}
{
  output.bibitem
  format.authors "author" output.check
  format.title
  "title" output.check
  format.tr.number output
  institution "institution" bibinfo.warn output
  address bibinfo.check output
  format.date "year" output.check
  format.note output
  format.url output
  fin.entry
}
FUNCTION {unpublished}
{
  output.bibitem
  format.authors "author" output.check
  format.title "title" output
  format.date output
  format.note "note" output.check
  format.url output
  fin.entry
}
FUNCTION {conference} { inproceedings }
FUNCTION {default.type} { misc }
FUNCTION {begin.bib}
{
  "\begin{thebibliography}{"  longest.label  * "}" * write$ newline$
}
FUNCTION {end.bib}
{
  newline$
  "\end{thebibliography}" write$ newline$
}
FUNCTION {initialize.longest.label}
{
  "" 'longest.label :=
  #1 'number.label :=
  #0 'longest.label.width :=
}
FUNCTION {init.consts}
{
  #0 'before.all :=
  #1 'mid.sentence :=
  #2 'new.sentence :=
}
FUNCTION {longest.label.pass}
{
  number.label int.to.str$ 'label :=
  number.label #1 + 'number.label :=
  label width$ longest.label.width >
    {
      label 'longest.label :=
      label width$ 'longest.label.width :=
    }
    'skip$
  if$
}
FUNCTION {write.babel.misc}
{
  "\providecommand{\bbland}{i}" write$ newline$
  "\providecommand{\bblchap}{rozdz.}" write$ newline$
  "\providecommand{\bblchapter}{rozdzia\l}" write$ newline$
  "\providecommand{\bbletal}{i~in.}" write$ newline$
  "\providecommand{\bbleditors}{edytorzy}" write$ newline$
  "\providecommand{\bbleds}{ed.}" write$ newline$
  "\providecommand{\bbleditor}{edytor}" write$ newline$
  "\providecommand{\bbled}{ed.}" write$ newline$
  "\providecommand{\bbledition}{edycja}" write$ newline$
  "\providecommand{\bbledn}{ed.}" write$ newline$
  "\providecommand{\bbleidp}{strona}" write$ newline$
  "\providecommand{\bbleidpp}{strony}" write$ newline$
  "\providecommand{\bblerratum}{errata}" write$ newline$
  "\providecommand{\bblin}{w}" write$ newline$
  "\providecommand{\bblmthesis}{praca magisterska}" write$ newline$
  "\providecommand{\bblbthesis}{praca licencjacka}" write$ newline$
  "\providecommand{\bblno}{nr}" write$ newline$
  "\providecommand{\bblnumber}{numer}" write$ newline$
  "\providecommand{\bblof}{z}" write$ newline$
  "\providecommand{\bblpage}{strona}" write$ newline$
  "\providecommand{\bblpages}{strony}" write$ newline$
  "\providecommand{\bblp}{str.}" write$ newline$
  "\providecommand{\bblphdthesis}{praca doktorska}" write$ newline$
  "\providecommand{\bblpp}{str.}" write$ newline$
  "\providecommand{\bbltechrep}{Opis Techn.}" write$ newline$
  "\providecommand{\bbltechreport}{Opis Techniczny}" write$ newline$
  "\providecommand{\bblvolume}{tom}" write$ newline$
  "\providecommand{\bblvol}{t.}" write$ newline$
}
FUNCTION {write.babel.months}
{
  "\providecommand{\bbljan}{stycze??}" write$ newline$
  "\providecommand{\bblfeb}{luty}" write$ newline$
  "\providecommand{\bblmar}{marzec}" write$ newline$
  "\providecommand{\bblapr}{kwiecie??}" write$ newline$
  "\providecommand{\bblmay}{maj}" write$ newline$
  "\providecommand{\bbljun}{czerwiec}" write$ newline$
  "\providecommand{\bbljul}{lipiec}" write$ newline$
  "\providecommand{\bblaug}{sierpie??}" write$ newline$
  "\providecommand{\bblsep}{wrzesie??}" write$ newline$
  "\providecommand{\bbloct}{pa??dziernik}" write$ newline$
  "\providecommand{\bblnov}{listopad}" write$ newline$
  "\providecommand{\bbldec}{grudzie??}" write$ newline$
}
FUNCTION {write.babel.ordinals}
{
  "\providecommand{\bblfirst}{pierwszy}" write$ newline$
  "\providecommand{\bblfirsto}{1.}" write$ newline$
  "\providecommand{\bblsecond}{drugi}" write$ newline$
  "\providecommand{\bblsecondo}{2.}" write$ newline$
  "\providecommand{\bblthird}{trzeci}" write$ newline$
  "\providecommand{\bblthirdo}{3.}" write$ newline$
  "\providecommand{\bblfourth}{czwarty}" write$ newline$
  "\providecommand{\bblfourtho}{4.}" write$ newline$
  "\providecommand{\bblfifth}{pi??ty}" write$ newline$
  "\providecommand{\bblfiftho}{5.}" write$ newline$
  "\providecommand{\bblst}{-wszy}" write$ newline$
  "\providecommand{\bblnd}{-gi}" write$ newline$
  "\providecommand{\bblrd}{-ci}" write$ newline$
  "\providecommand{\bblth}{-ty}" write$ newline$
}
FUNCTION {write.babel}
{
  write.babel.misc
  write.babel.months
  write.babel.ordinals
}
FUNCTION {write.commands}
{
  "\providecommand{\url}[1]{\texttt{#1}}" write$ newline$
  "\providecommand{\urlprefix}{}" write$ newline$
  "\providecommand{\foreignlanguage}[2]{#2}" write$ newline$
  "\providecommand{\Capitalize}[1]{\uppercase{#1}}" write$ newline$
  "\providecommand{\capitalize}[1]{\expandafter\Capitalize#1}" write$ newline$
  "\providecommand{\bibliographycite}[1]{\cite{#1}}" write$ newline$
  write.babel
}
FUNCTION {write.header}
{
  preamble$ empty$
    'skip$
    { preamble$ write$ newline$ }
  if$
  write.commands
}
READ
EXECUTE {initialize.longest.label}
ITERATE {longest.label.pass}
EXECUTE {init.consts}
EXECUTE {write.header}
EXECUTE {begin.bib}
ITERATE {call.type$}
EXECUTE {end.bib}
