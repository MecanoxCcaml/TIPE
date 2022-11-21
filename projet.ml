include Graphics;;

Graphics.open_graph "";;

let points: (int*int) list ref = ref [];;

let edges: (int*int) edge list ref = ref [];;

let draw_point (x,y) = Graphics.fill_circle x y 2;;

let draw_points () = List.iter draw_point !points;;

let add_edge (x1,y1) (x2,y2) =
  edges := ((x1,y1),(x1-x2)*(x1-x2)+(y1-y2)*(y1-y2),(x2,y2))::!edges;;

let draw_edge ((x1,y1),_,(x2,y2)) =
  Graphics.moveto x1 y1; Graphics.lineto x2 y2;;

let click (status : Graphics.status) =
  let (x,y) = (status.mouse_x, status.mouse_y) in
  Graphics.clear_graph ();
  List.iter (add_edge (x,y)) !points;
  points := (x,y) :: !points;
  draw_points ();
  List.iter draw_edge (kruskal (!points,!edges))
;;

Graphics.loop_at_exit [Graphics.Button_down] click;;