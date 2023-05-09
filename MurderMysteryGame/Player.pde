final class Player extends Entity {
    private ArrayList<PImage> _right_images;
    private ArrayList<PImage> _left_images;
    private ArrayList<PImage> _up_images;
    private ArrayList<PImage> _down_images;
    private ArrayList<PImage> _standing_right_images;
    private ArrayList<PImage> _standing_left_images;
    private ArrayList<PImage> _standing_up_images;
        private ArrayList<PImage> _standing_down_images;

    private int _current_frame = 0;
    private int _frame_delay = 5; // Increase or decrease this value to adjust the animation speed
    private int _frame_count = 0;
    private int _orientation = 1; // 1 for right, -1 for left, 0 for up

    Player() {
        super(2, 1, "player");
        
        _right_images = new ArrayList<PImage>();
        _left_images = new ArrayList<PImage>();
        _up_images = new ArrayList<PImage>();
        _down_images = new ArrayList<PImage>();

        
        _standing_right_images = new ArrayList<PImage>();
        _standing_left_images = new ArrayList<PImage>();
        _standing_up_images = new ArrayList<PImage>();
        _standing_down_images = new ArrayList<PImage>();

        // Load the left-facing, right-facing, and up-facing images into their respective ArrayLists
        for (int i = 0; i < 3; i++) {
            String fileName = "sprite0" + (char)('a'+i) + ".png";
            PImage img = loadImage(fileName);
            _left_images.add(img);
            
            fileName = "sprite1" + (char)('a'+i) + ".png";
            img = loadImage(fileName);
            _right_images.add(img);
            
            fileName = "sprite2" + (char)('a'+i) + ".png";
            img = loadImage(fileName);
            _up_images.add(img);
            
              fileName = "sprite3" + (char)('a'+i) + ".png";
            img = loadImage(fileName);
            _down_images.add(img);
        }
        
        // Load the standing right-facing, left-facing, and up-facing images into their respective ArrayLists
       
        PImage standing_left_img = loadImage("sprite0a.png");
        _standing_left_images.add(standing_left_img);
        
         PImage standing_right_img = loadImage("sprite1a.png");
        _standing_right_images.add(standing_right_img);
        
        PImage standing_up_img = loadImage("sprite2a.png");
        _standing_up_images.add(standing_up_img);
        
         PImage standing_down_img = loadImage("sprite3a.png");
        _standing_down_images.add(standing_down_img);
    }
    
    
    
    
    
void handleInput(boolean[] input_array, float frame_duration) {

    // Zero out movement vector
    super.movement_vector.set(0, 0);

    // Use kinematic motion for movement, where w,a,s,d all cause movement in their own directions. We rotate the player to face the direction of travel.
    if (input_array[0]) {
        super.movement_vector.sub(1, 0);
        // Set the image for the left-facing animation
        setImage(_left_images.get(_current_frame % _left_images.size()));
    }

    if (input_array[1]) {
        super.movement_vector.add(1, 0);
        // Set the image for the right-facing animation
        setImage(_right_images.get(_current_frame % _right_images.size()));
    }

    if (input_array[2]) {
        super.movement_vector.sub(0, 1);
        // Set the image for the up-facing animation
        setImage(_up_images.get(_current_frame % _up_images.size()));
    }

    if (input_array[3]) {
        super.movement_vector.add(0, 1);
        // Set the image for the down-facing animation
        setImage(_down_images.get(_current_frame % _down_images.size()));
    }





    super.moveEntity(frame_duration);
}


void drawComponent(int tile_size) {
    float entity_x = tile_size * super.getLocation().x;
    float entity_y = tile_size * super.getLocation().y;
    pushMatrix();
    translate(entity_x + tile_size/2, entity_y + tile_size/2);

    if (super.movement_vector.x > 0) { // moving right
        // Calculate the index of the current right-facing image
        int right_index = (_current_frame / 2) % _right_images.size();

        // Draw the current right-facing image
        image(_right_images.get(right_index), -tile_size/2, -tile_size/2, tile_size, tile_size);
    } 
   
    
    
    else if (super.movement_vector.x < 0) { // moving left
        // Calculate the index of the current left-facing image
        int left_index = (_current_frame / 2) % _left_images.size();

        // Draw the current left-facing image
        image(_left_images.get(left_index), -tile_size/2, -tile_size/2, tile_size, tile_size);
    } 
    
    
    else if (super.movement_vector.y < 0) { // moving up
        // Calculate the index of the current up-facing image
        int up_index = (_current_frame / 2) % _up_images.size();

        // Draw the current up-facing image
        image(_up_images.get(up_index), -tile_size/2, -tile_size/2, tile_size, tile_size);
    } 
    
    
    
    else if (super.movement_vector.y > 0) { // moving down
        // Calculate the index of the current down-facing image
        int down_index = (_current_frame / 2) % _down_images.size();

        // Draw the current down-facing image
        image(_down_images.get(down_index), -tile_size/2, -tile_size/2, tile_size, tile_size);
    } 

    
    else { // standing still
        if (super.orientation == 1) { // facing right
            // Draw the first right-facing image
            image(_standing_right_images.get(0), -tile_size/2, -tile_size/2, tile_size, tile_size);
        } 
       
        
        else if (super.orientation == 3) { // facing left
            // Draw the first left-facing image
            image(_standing_left_images.get(0), -tile_size/2, -tile_size/2, tile_size, tile_size);
        } 
       
        
        else if (super.orientation == 2) { // facing down
            // Draw the first down-facing image
            image(_standing_down_images.get(0), -tile_size/2, -tile_size/2, tile_size, tile_size);
        }
      
        else { // standing still facing up
            // Draw the standing up-facing image
          image(_standing_up_images.get(0), -tile_size/2, -tile_size/2, tile_size, tile_size);
        }
    }
    

    // Increment the current frame counter
    _frame_count++;
    if (_frame_count >= _frame_delay) {
        _current_frame++;
        _frame_count = 0;
    }

    popMatrix();
} 

}
