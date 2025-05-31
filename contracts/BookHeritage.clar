;; BookHeritage: Rare Book Authentication and Registry Platform
;; Version: 1.0.0
(define-constant ERR-NOT-AUTHORIZED (err u1))
(define-constant ERR-BOOK-NOT-FOUND (err u2))
(define-constant ERR-ALREADY-CATALOGUED (err u3))
(define-constant ERR-INVALID-STATUS (err u4))
(define-constant ERR-INVALID-PUBLICATION-YEAR (err u5))
(define-constant ERR-INVALID-GENRE (err u6))
(define-constant ERR-INVALID-PRESERVATION (err u7))
(define-constant ERR-INVALID-TITLE (err u8))
(define-constant ERR-INVALID-PROVENANCE (err u9))
(define-constant MIN-PUBLICATION-YEAR u1450)
(define-data-var next-book-id uint u1)
(define-map rare-books
    uint
    {
        librarian: principal,
        book-title: (string-utf8 50),
        provenance: (string-utf8 200),
        genre: (string-utf8 15),
        preservation: (string-utf8 15),
        availability: (string-utf8 10),
        publication-year: uint
    }
)
(define-private (validate-genre (genre (string-utf8 15)))
    (or 
        (is-eq genre u"Literature")
        (is-eq genre u"History")
        (is-eq genre u"Science")
        (is-eq genre u"Philosophy")
        (is-eq genre u"Religion")
        (is-eq genre u"Art")
    )
)
(define-private (validate-preservation (preservation (string-utf8 15)))
    (or 
        (is-eq preservation u"Pristine")
        (is-eq preservation u"Fine")
        (is-eq preservation u"Very Good")
        (is-eq preservation u"Good")
        (is-eq preservation u"Fragile")
    )
)
(define-private (validate-text-content (text (string-utf8 200)) (min-length uint) (max-length uint))
    (let 
        (
            (text-length (len text))
        )
        (and 
            (>= text-length min-length)
            (<= text-length max-length)
        )
    )
)
(define-public (catalogue-book 
    (book-title (string-utf8 50))
    (provenance (string-utf8 200))
    (genre (string-utf8 15))
    (preservation (string-utf8 15))
    (publication-year uint)
)
    (let
        (
            (book-id (var-get next-book-id))
        )
        (asserts! (validate-text-content book-title u3 u50) ERR-INVALID-TITLE)
        (asserts! (validate-text-content provenance u10 u200) ERR-INVALID-PROVENANCE)
        (asserts! (>= publication-year MIN-PUBLICATION-YEAR) ERR-INVALID-PUBLICATION-YEAR)
        (asserts! (validate-genre genre) ERR-INVALID-GENRE)
        (asserts! (validate-preservation preservation) ERR-INVALID-PRESERVATION)
        
        (map-set rare-books book-id {
            librarian: tx-sender,
            book-title: book-title,
            provenance: provenance,
            genre: genre,
            preservation: preservation,
            availability: u"catalogued",
            publication-year: publication-year
        })
        (var-set next-book-id (+ book-id u1))
        (ok book-id)
    )
)
(define-public (archive-book (book-id uint))
    (let
        (
            (book (unwrap! (map-get? rare-books book-id) ERR-BOOK-NOT-FOUND))
        )
        (asserts! (is-eq tx-sender (get librarian book)) ERR-NOT-AUTHORIZED)
        (asserts! (is-eq (get availability book) u"catalogued") ERR-INVALID-STATUS)
        (ok (map-set rare-books book-id (merge book { availability: u"archived" })))
    )
)
(define-read-only (get-book (book-id uint))
    (ok (map-get? rare-books book-id))
)
(define-read-only (get-librarian (book-id uint))
    (ok (get librarian (unwrap! (map-get? rare-books book-id) ERR-BOOK-NOT-FOUND)))
)