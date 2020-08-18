
setAiffArtworkFromDiscogs() {

    # Curl Discogs with title of track.

    kid3-cli -c 'select "$1"' -c 'set picture:"/path/to/coverart.jpg" "Picture Description"' -c 'save'
}