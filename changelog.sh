changelog=CHANGELOG.md
version="1.2.3"
# use below to correspond with your tagged version
# version="$(git describe --long)"
date="$(date '+%Y-%m-%d')"
item="## [$version] - $date"

new_changelog()
{
  echo "# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

$item
### Added 
- ADD CHANGE HERE!
" > CHANGELOG.md
}

new_changelog_item()
{   
    echo $item

    if grep -Fxq "$item" CHANGELOG.md; then 
        echo "Changelog item already exists for
    $item"
    else
        while read line; do
            if [[ $line == "## [Unreleased]"* ]]; then
                newvar=$(<<<"$line" sed 's/[].*[]/\\&/g')
                sed -i "" "s/$newvar/## [Unreleased]\n\n$item\n### Added\n- ADD CHANGE HERE!/" CHANGELOG.md
                return
            fi
        done < CHANGELOG.md
    fi

}

init()
{
    if test -f "$changelog" ; then
        new_changelog_item
    else
        new_changelog
    fi
}

init