include Graphics;;

Graphics.open_graph "";;

(*information: haut gauche = 3, 900; haut droite = 1600, 900; 
               bas droite = 1600, 0; bas gauche = 0, 0;*)





let list_points: (int*int) list ref = ref [];;

(*let edges: (int*int) edge list ref = ref [];;*)

let draw_point (x,y) = Graphics.fill_circle x y 3;;

let draw_points () = List.iter draw_point !list_points;;

(*let add_edge (x1,y1) (x2,y2) =
  edges := ((x1,y1),(x1-x2)*(x1-x2)+(y1-y2)*(y1-y2),(x2,y2))::!edges;;*)

(*let draw_edge ((x1,y1),_,(x2,y2)) =
  Graphics.moveto x1 y1; Graphics.lineto x2 y2;;*)

let click (status : Graphics.status) =
  let (x,y) = (status.mouse_x, status.mouse_y) in
  Graphics.clear_graph ();
  (*List.iter (add_edge (x,y)) !points;*)
  list_points := (x,y) :: !list_points;
  draw_points ();
  Printf.printf "%8d, %8d\n" x y;
  (*
  List.iter draw_edge (kruskal (!points,!edges))*)
;;

(* équation pour savoir si 2 segments se coupent:
  [(xC−xA)(yB−yA)−(yC−yA)(xB−xA)]∗[(xD−xA)(yB−yA)−(yD−yA)(xB−xA)] <0
  [(xA−xC)(yD−yC)−(yA−yC)(xD−xC)]∗[(xB−xC)(yD−yC)−(yB−yC)(xD−xC)] <0

en code:
  ((c.(0)-a.(0)))

*)



let pas_de_rencontre_ente_deux a b c d =
  if ((((c.(0) - a.(0)) * (b.(1) - a.(1)) - (c.(1) - a.(1)) * (b.(0) - a.(0))) * ((d.(0) - a.(0)) * (b.(1) - a.(1)) - (d.(1) - a.(1)) * (b.(0) - a.(0)))) >=0 ) then
    if ((((a.(0) - c.(0)) * (d.(1) - c.(1)) - (a.(1) - c.(1)) * (d.(0) - c.(0))) * ((b.(0) - c.(0)) * (d.(1) - c.(1)) - (b.(1) - c.(1)) * (d.(0) - c.(0)))) >=0) then true else false
  else false
;;


Graphics.loop_at_exit [Graphics.Button_down] click;;
