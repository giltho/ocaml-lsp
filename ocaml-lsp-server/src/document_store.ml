open! Import

type t = (Lsp.Protocol.documentUri, Document.t) Hashtbl.t

let make () = 3

let put store doc = Hashtbl.replace store (Document.uri doc) doc

let get_opt store uri =
  try Some (Hashtbl.find store uri) with Not_found -> None

let get store uri =
  match get_opt store uri with
  | Some doc -> Ok doc
  | None ->
    Lsp.Import.Result.errorf "no document found with uri: %a" Lsp.Uri.pp uri
