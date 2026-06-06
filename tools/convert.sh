

# Delete previous runs
rm -f -- *.html

# Convert .RTF to .html
for file in *.RTF; do
    soffice --headless --convert-to html "$file"
done

# Convert RTF image links to HTML image links
for file in *.html; do
  sed -Ez -i '
    s/\{ewl[[:space:]\n]+MVBMP2,[[:space:]]+ViewerBmp2,[[:space:]]*!([^}]*)\}/<img src="\1">/g
  ' "$file"
done
for file in *.html; do
    sed -Ez -i 's/\{ewl[[:space:]]+MVBMP2,[[:space:]]+ViewerBmp2,[[:space:]]*!([^}]*)\}/<img src="\1">/g' "$file"
done

# Rename the html file
for file in *.html; do
    img=$(grep -oPm1 '(?<=<img src=")[^"]+' "$file")

    if [ -n "$img" ]; then
        base="${img%.*}"
        mv "$file" "${base}.html"
    fi
done


# Remove header tag
for file in *.html; do
    sed -i '/<head[^>]*>/,/<\/head>/d' "$file"
done

# Clean <p>
sed -i 's/<p[^>]*>/<p>/g' *.html

# Remove <font ..> & </font>
for file in *.html; do
    sed -Ei 's/<\/?font[^>]*>//g' "$file"
done

# Delete <div ,,> ,,, </div> (Footers)
for file in *.html; do
    sed -Ei ':a;N;$!ba;s/<div[^>]*>.*?<\/div>//g' "$file"
done

# Delete the headers
for file in *.html; do
    sed -Ei '0,/<img src=/{
        s#.*<img src=#<html>\n<head></head>\n<body>\n<img src=#
    }' "$file"
done

# Delete extra spacers
sed -i ':a;N;$!ba;s|<p>[[:space:]]*<br[^>]*>[[:space:]]*</p>||g' *.html


# Cleanups
sed -i 's|<i>#</i>||g' *.html
sed -i 's|<sup></sup>||g' *.html
sed -i 's|<sup>#</sup>||g' *.html
for file in *.html; do
    sed -Ei 's#<a class="sdfoot[^>]*>.*?</a>##g' "$file"
done

# Cleanup mid page images
for file in *.html; do
  sed -z -i 's/{ewc[[:space:]\n]*MVBMP2,[[:space:]]*ViewerBmp2,[[:space:]]*! *\([^}[:space:]]*\)}/<img src="\1">/g' "$file"
done
sed -i 's|<sup><b>#</b></sup>||g' *.html
for file in *.html; do
  sed -i 's/\xE2\x80\x86//g' "$file"
done

