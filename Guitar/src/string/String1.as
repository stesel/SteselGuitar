package string {

	import alternativa.engine3d.core.VertexAttributes;
	import alternativa.engine3d.materials.Material;
	import alternativa.engine3d.objects.Joint;
	import alternativa.engine3d.objects.Skin;
	import alternativa.engine3d.resources.Geometry;
	
	import flash.geom.Matrix3D;

	public class String1 extends Skin {

		private var kappa:Number = 25 ;
		private var omega:Number = Math.PI/2;

		public function String1(angle:Number, radius:Number, material:Material, rad:Number) {
			super(2);
			
			x = radius*Math.cos(angle);
			y = radius*Math.sin(angle);
			rotationZ = angle;
			
			var n:Number;
			var v:Number = 0;
			var h:Number = 5.25;
			var r:Number = rad;
			var usegments:int = 10;
			var vsegments:int = 50;
			var radiusDecreaseStep:Number = r/vsegments;
			var dAlpha:Number = 2*Math.PI/usegments;
			var row:int;

			// Vertices
			var vertices:Vector.<Number> = new Vector.<Number>();
			var uvs:Vector.<Number> = new Vector.<Number>();
			for (row = 0; row < vsegments; row++) {
				for (var alpha:Number = 0; alpha < Math.PI*2 - 0.01; alpha += dAlpha) {
					vertices.push(r*Math.sin(alpha), r*Math.cos(alpha), -row*h);
					uvs.push(alpha/Math.PI, v);
				}
				v += 0.33;
				//r -= radiusDecreaseStep;
			}
			
			// Bones
			var bones:Vector.<Number> = new Vector.<Number>();
			for (row = 0; row < vsegments; row++) {
				for (n = 0; n < usegments; n++) {
					bones.push(row*3, 1, 0, 0);
				}
			}
			
			// Indices
			var indices:Vector.<uint> = new Vector.<uint>();
			for (row = 0; row < vsegments - 1; row++) {
				for (n = 0; n < usegments - 1; n++) {
					indices.push(usegments*row + n, (n + 1) + row*usegments, usegments*(row + 1) + n);
					indices.push((n + 1) + row*usegments, (n + 1) + usegments*(row + 1), usegments*(row + 1) + n);
				}
				indices.push(usegments*row + usegments - 1, row*usegments, usegments*(row + 1) + usegments - 1);
				indices.push(row*usegments, (row + 1)*usegments, usegments*(row + 1) + usegments - 1);
			}
			
			// Geometry
			geometry = new Geometry(vertices.length/3);
			geometry.addVertexStream([
				VertexAttributes.POSITION,
				VertexAttributes.POSITION,
				VertexAttributes.POSITION,
				VertexAttributes.JOINTS[0],
				VertexAttributes.JOINTS[0],
				VertexAttributes.JOINTS[0],
				VertexAttributes.JOINTS[0],
				VertexAttributes.TEXCOORDS[0],
				VertexAttributes.TEXCOORDS[0]
			]);
			geometry.setAttributeValues(VertexAttributes.POSITION, vertices);
			geometry.setAttributeValues(VertexAttributes.JOINTS[0], bones);
			geometry.setAttributeValues(VertexAttributes.TEXCOORDS[0], uvs);
			geometry.indices = indices;
			
			// Surface
			addSurface(material, 0, geometry.numTriangles);
			
			
			// Fills joints vector
			renderedJoints = new Vector.<Joint>();
			
			
			var joint:Joint;
			var jointMatrix:Matrix3D;

			
			var cm:Matrix3D = concatenatedMatrix;
			cm.invert();
			for (n = 0; n < vsegments; n++)
			{
				joint = new Joint();
				joint.z = -h;
				//if (n > 0) {
					//renderedJoints[renderedJoints.length - 1].addChild(joint);
				//}
				//else 
				//{
					addChild(joint);
				//}
				renderedJoints.push(joint);
				jointMatrix = joint.concatenatedMatrix;
				jointMatrix.append(cm);
				jointMatrix.invert();
				joint.bindingMatrix = jointMatrix;
			
				
			}
			
			divide(40);
		}

		public function update(t:Number, friction:Number):void {
			 //friction -= 0.01; 
			for (var v:int= 1; v < 50; v++) {
				renderedJoints[50 -v].rotationY = (Math.sqrt(friction)) * (0.00005 + 0.0001 * v) * Math.sin(t);
				//if (friction <= 0)
				//renderedJoints[50 -v].rotationY =  0;
				//renderedJoints[v].rotationY = 0.005*Math.sin(omega + t + v/kappa);
			}
			
			//for (var v2:int= 0; v2 < renderedJoints.length - 20; v2++) {
				//renderedJoints[30 - v2].rotationY = 0.03*Math.sin(omega + t + v2/kappa);
				//renderedJoints[v].rotationY = 0.005*Math.sin(omega + t + v/kappa);
			//}
		}
		
		public function restore():void {
			for (var v:int= 1; v < 50; v++) {
				renderedJoints[50 -v].rotationY = 0;
		}
		}

	}
}